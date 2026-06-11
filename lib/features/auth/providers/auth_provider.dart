import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/auth_service.dart';
import '../../../data/database/app_database.dart';
import '../../../main.dart';

// ============================================================
// AUTH STATE
// ============================================================

class AuthState {
  final bool isLoggedIn;
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isLoggedIn = false,
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// ============================================================
// AUTH PROVIDER
// ============================================================

final authServiceProvider = Provider<AuthService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AuthService(db);
});

final authStateProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    final authService = ref.read(authServiceProvider);
    final isValid = await authService.isSessionValid();
    if (isValid) {
      final user = await authService.getCurrentUser();
      return AuthState(isLoggedIn: true, user: user);
    }
    return const AuthState(isLoggedIn: false);
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    final authService = ref.read(authServiceProvider);
    try {
      final result = await authService.login(
        username: username,
        password: password,
      );
      if (result.success) {
        state = AsyncValue.data(AuthState(isLoggedIn: true, user: result.user));
      } else {
        state = AsyncValue.data(AuthState(
          isLoggedIn: false,
          error: result.message,
        ));
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loginBiometric() async {
    state = const AsyncValue.loading();
    final authService = ref.read(authServiceProvider);
    try {
      final result = await authService.loginWithBiometric();
      if (result.success) {
        state = AsyncValue.data(AuthState(isLoggedIn: true, user: result.user));
      } else {
        state = AsyncValue.data(AuthState(
          isLoggedIn: false,
          error: result.message,
        ));
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    String? fullName,
  }) async {
    state = const AsyncValue.loading();
    final authService = ref.read(authServiceProvider);
    try {
      final result = await authService.register(
        username: username,
        email: email,
        password: password,
        fullName: fullName,
      );
      if (result.success) {
        // Auto-login setelah register
        await login(username, password);
      } else {
        state = AsyncValue.data(AuthState(
          isLoggedIn: false,
          error: result.message,
        ));
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    final authService = ref.read(authServiceProvider);
    await authService.logout();
    state = const AsyncValue.data(AuthState(isLoggedIn: false));
  }

  Future<void> refreshUser() async {
    final authService = ref.read(authServiceProvider);
    final user = await authService.getCurrentUser();
    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncValue.data(current.copyWith(user: user));
    }
  }
}

// Provider untuk user saat ini
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).valueOrNull?.user;
});
