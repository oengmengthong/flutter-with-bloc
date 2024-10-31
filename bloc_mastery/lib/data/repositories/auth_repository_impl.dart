// lib/data/repositories/auth_repository_impl.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final http.Client client;

  AuthRepositoryImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<User> login(String username, String password) async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();
    final response = await client.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      await prefs.setString('accessToken', jsonResponse['accessToken']);
      await prefs.setString(
          'refreshToken', jsonResponse['refreshToken']);

      final userModel = UserModel.fromJson(jsonResponse);
      return userModel.toEntity();
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['message'] ?? 'Failed to login');
    }
  }

  @override
  Future<void> logout() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }

  @override
  Future<void> refreshToken() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    final storedRefreshToken = await prefs.getString('refreshToken');
    if (storedRefreshToken == null) {
      throw Exception('No refresh token available');
    }

    final response = await client.post(
      Uri.parse('https://dummyjson.com/auth/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'refreshToken': storedRefreshToken,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      await prefs.setString('accessToken', jsonResponse['accessToken']);
      await prefs.setString(
          'refreshToken', jsonResponse['refreshToken']);
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['message'] ?? 'Failed to refresh token');
    }
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    var accessToken = await prefs.getString('accessToken');
    return accessToken;
  }
}
