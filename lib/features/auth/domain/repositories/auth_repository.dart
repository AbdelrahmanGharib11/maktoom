import 'package:maktoom/features/auth/data/models/user_dto.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Result<UserDTO, Failure>> login(String email, String password);
  Future<Result<void, Failure>> register(
    String email,
    String password,
    String name,
  );
  Future<Result<void, Failure>> forgotPassword(String email);
  Future<Result<void, Failure>> verifyOtp(String email, String otp);
  Future<Result<void, Failure>> logout();
  Future<UserDTO?> getCurrentUser();
}

// Simple Result wrapper
class Result<T, E> {
  final T? data;
  final E? error;

  Result.success(this.data) : error = null;
  Result.failure(this.error) : data = null;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}
