import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../data/database/app_database.dart';
import '../../../core/services/auth_service.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../../../main.dart';

class ProfileState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final bool isEditing;

  const ProfileState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.isEditing = false,
  });

  ProfileState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    bool? isEditing,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final AppDatabase _db;
  final AuthService _authService;
  final Ref _ref;

  ProfileNotifier(this._db, this._authService, this._ref)
      : super(const ProfileState()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authService.getCurrentUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> pickAndSavePhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (picked == null) return;

    try {
      final dir = await getApplicationDocumentsDirectory();
      final filename = 'avatar_${state.user?.id ?? 0}.jpg';
      final dest = File(p.join(dir.path, filename));
      await File(picked.path).copy(dest.path);

      if (state.user != null) {
        await _db.updateUserAvatar(state.user!.id, dest.path);
        await _loadProfile();
        state = state.copyWith(
            successMessage: 'Foto profil berhasil diperbarui');
      }
    } catch (e) {
      state = state.copyWith(errorMessage: 'Gagal menyimpan foto: $e');
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    String? phone,
  }) async {
    if (state.user == null) return;
    state = state.copyWith(isLoading: true);
    try {
      await _db.updateUserProfile(
        id: state.user!.id,
        name: name,
        email: email,
        phone: phone,
      );
      await _loadProfile();
      // _loadProfile resets isLoading; set success message after
      state = state.copyWith(
        successMessage: 'Profil berhasil diperbarui',
        isEditing: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (state.user == null) return;
    state = state.copyWith(isLoading: true);
    try {
      final ok = await _authService.changePassword(
        userId: state.user!.id,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      state = state.copyWith(
        isLoading: false,
        successMessage: ok ? 'Password berhasil diubah' : null,
        errorMessage: ok ? null : 'Password lama tidak cocok',
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _ref.invalidate(profileProvider);
    _ref.invalidate(authStateProvider);
  }

  void clearMessages() =>
      state = state.copyWith(errorMessage: null, successMessage: null);

  void setEditing(bool value) => state = state.copyWith(isEditing: value);
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final auth = ref.watch(authServiceProvider);
  return ProfileNotifier(db, auth, ref);
});
