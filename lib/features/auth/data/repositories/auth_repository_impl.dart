import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_dto.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  AuthRepositoryImpl(this._dio, this._storage);

  @override
  Future<Result<UserDTO, Failure>> login(String email, String password) async {
    try {
      final response = await _dio.post(ApiEndpoints.login, data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final user = UserDTO.fromJson(response.data['user']);
        final token = response.data['token'];
        await _storage.write(key: 'access_token', value: token);
        return Result.success(user);
      }
      return Result.failure(const ServerFailure('Invalid credentials'));
    } on DioException catch (e) {
      return Result.failure(ServerFailure(e.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Result<void, Failure>> register(String email, String password, String name) async {
    try {
      await _dio.post(ApiEndpoints.register, data: {
        'email': email,
        'password': password,
        'name': name,
      });
      return Result.success(null);
    } on DioException catch (e) {
      return Result.failure(ServerFailure(e.message ?? 'Registration failed'));
    }
  }

  @override
  Future<Result<void, Failure>> forgotPassword(String email) async {
    try {
      await _dio.post(ApiEndpoints.forgotPassword, data: {'email': email});
      return Result.success(null);
    } on DioException catch (e) {
      return Result.failure(ServerFailure(e.message ?? 'Request failed'));
    }
  }

  @override
  Future<Result<void, Failure>> verifyOtp(String email, String otp) async {
    try {
      await _dio.post(ApiEndpoints.verifyOtp, data: {
        'email': email,
        'otp': otp,
      });
      return Result.success(null);
    } on DioException catch (e) {
      return Result.failure(ServerFailure(e.message ?? 'Verification failed'));
    }
  }

  @override
  Future<Result<void, Failure>> logout() async {
    await _storage.delete(key: 'access_token');
    return Result.success(null);
  }

  @override
  Future<UserDTO?> getCurrentUser() async {
    // Logic to fetch user from storage or API
    return null;
  }
}
