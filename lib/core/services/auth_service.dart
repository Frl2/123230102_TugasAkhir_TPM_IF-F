import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:drift/drift.dart';

import '../constants/app_constants.dart';
import '../../data/database/app_database.dart';

class AuthResult {
  final bool success;
  final String? message;
  final User? user;

  const AuthResult({
    required this.success,
    this.message,
    this.user,
  });
}

class AuthService {
  final AppDatabase _db;
  final FlutterSecureStorage _secureStorage;
  final LocalAuthentication _localAuth;

  AuthService(this._db)
      : _secureStorage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock_this_device,
          ),
        ),
        _localAuth = LocalAuthentication();

  // =====================
  // PASSWORD HASHING
  // =====================

  /// Generate random salt (16 bytes)
  String _generateSalt() {
    final random = Random.secure();
    final saltBytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64Encode(saltBytes);
  }

  /// Hash password dengan SHA-256 + salt
  String _hashPassword(String password, String salt) {
    final combined = '$password:$salt';
    final bytes = utf8.encode(combined);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Generate session token (JWT-like, 32 byte random)
  String _generateSessionToken() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  // =====================
  // REGISTER
  // =====================
  Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      // Cek username sudah ada
      final existing = await _db.getUserByUsername(username);
      if (existing != null) {
        return const AuthResult(
          success: false,
          message: 'Username sudah digunakan',
        );
      }

      // Hash password
      final salt = _generateSalt();
      final passwordHash = _hashPassword(password, salt);

      // Insert user ke database
      final userId = await _db.insertUser(
        UsersCompanion.insert(
          username: username,
          email: email,
          passwordHash: passwordHash,
          salt: salt,
          fullName: Value(fullName),
        ),
      );

      final user = await _db.getUserById(userId);
      return AuthResult(success: true, user: user, message: 'Registrasi berhasil');
    } catch (e) {
      return AuthResult(success: false, message: 'Terjadi kesalahan: $e');
    }
  }

  // =====================
  // LOGIN
  // =====================
  Future<AuthResult> login({
    required String username,
    required String password,
  }) async {
    try {
      final user = await _db.getUserByUsername(username);
      if (user == null) {
        return const AuthResult(
          success: false,
          message: 'Username atau password salah',
        );
      }

      // Verifikasi password
      final hash = _hashPassword(password, user.salt);
      if (hash != user.passwordHash) {
        return const AuthResult(
          success: false,
          message: 'Username atau password salah',
        );
      }

      // Buat session token
      final token = _generateSessionToken();
      final expiry = DateTime.now().add(
        const Duration(hours: AppConstants.sessionDurationHours),
      );

      // Update session di database
      await _db.updateSession(user.id, token, expiry);

      // Simpan ke secure storage
      await _secureStorage.write(
        key: AppConstants.keySessionToken,
        value: token,
      );
      await _secureStorage.write(
        key: AppConstants.keyUserId,
        value: user.id.toString(),
      );

      return AuthResult(success: true, user: user, message: 'Login berhasil');
    } catch (e) {
      return AuthResult(success: false, message: 'Terjadi kesalahan: $e');
    }
  }

  // =====================
  // BIOMETRIC LOGIN
  // =====================
  Future<bool> isBiometricAvailable() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheck && isDeviceSupported;
    } catch (_) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (_) {
      return [];
    }
  }

  Future<AuthResult> loginWithBiometric() async {
    try {
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        return const AuthResult(
          success: false,
          message: 'Biometrik tidak tersedia',
        );
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Gunakan sidik jari atau wajah untuk masuk ke UrbanSafe',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (!authenticated) {
        return const AuthResult(
          success: false,
          message: 'Autentikasi biometrik gagal',
        );
      }

      // Ambil userId dari secure storage
      final userIdStr = await _secureStorage.read(key: AppConstants.keyUserId);
      if (userIdStr == null) {
        return const AuthResult(
          success: false,
          message: 'Data sesi tidak ditemukan, silakan login manual',
        );
      }

      final userId = int.tryParse(userIdStr);
      if (userId == null) {
        return const AuthResult(success: false, message: 'ID pengguna tidak valid');
      }

      final user = await _db.getUserById(userId);
      if (user == null) {
        return const AuthResult(success: false, message: 'Pengguna tidak ditemukan');
      }

      // Buat session baru
      final token = _generateSessionToken();
      final expiry = DateTime.now().add(
        const Duration(hours: AppConstants.sessionDurationHours),
      );
      await _db.updateSession(user.id, token, expiry);
      await _secureStorage.write(
        key: AppConstants.keySessionToken,
        value: token,
      );

      return AuthResult(success: true, user: user, message: 'Login biometrik berhasil');
    } catch (e) {
      return AuthResult(success: false, message: 'Error biometrik: $e');
    }
  }

  // =====================
  // SESSION MANAGEMENT
  // =====================
  Future<bool> isSessionValid() async {
    try {
      final token = await _secureStorage.read(key: AppConstants.keySessionToken);
      final userIdStr = await _secureStorage.read(key: AppConstants.keyUserId);
      if (token == null || userIdStr == null) return false;

      final userId = int.tryParse(userIdStr);
      if (userId == null) return false;

      final user = await _db.getUserById(userId);
      if (user == null) return false;

      // Cek token dan expiry
      if (user.sessionToken != token) return false;
      if (user.sessionExpiry == null) return false;
      if (DateTime.now().isAfter(user.sessionExpiry!)) {
        await logout();
        return false;
      }

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final userIdStr = await _secureStorage.read(key: AppConstants.keyUserId);
      if (userIdStr == null) return null;
      final userId = int.tryParse(userIdStr);
      if (userId == null) return null;
      return _db.getUserById(userId);
    } catch (_) {
      return null;
    }
  }

  Future<void> logout() async {
    try {
      final userIdStr = await _secureStorage.read(key: AppConstants.keyUserId);
      if (userIdStr != null) {
        final userId = int.tryParse(userIdStr);
        if (userId != null) {
          await _db.updateSession(userId, null, null);
        }
      }
      await _secureStorage.deleteAll();
    } catch (_) {}
  }

  Future<void> enableBiometric(int userId) async {
    await _secureStorage.write(
      key: AppConstants.keyBiometricEnabled,
      value: 'true',
    );
    await ((_db.update(_db.users))
          ..where((u) => u.id.equals(userId)))
        .write(const UsersCompanion(biometricEnabled: Value(true)));
  }

  Future<bool> isBiometricEnabled() async {
    final val = await _secureStorage.read(key: AppConstants.keyBiometricEnabled);
    return val == 'true';
  }

  Future<bool> changePassword({
    required int userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final user = await _db.getUserById(userId);
      if (user == null) return false;
      final oldHash = _hashPassword(oldPassword, user.salt);
      if (oldHash != user.passwordHash) return false;
      final newHash = _hashPassword(newPassword, user.salt);
      await (_db.update(_db.users)..where((u) => u.id.equals(userId)))
          .write(UsersCompanion(passwordHash: Value(newHash)));
      return true;
    } catch (_) {
      return false;
    }
  }
}
