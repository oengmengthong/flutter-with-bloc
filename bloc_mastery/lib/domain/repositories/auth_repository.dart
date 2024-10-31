// lib/domain/repositories/auth_repository.dart

import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<void> logout();
  Future<void> refreshToken();
}