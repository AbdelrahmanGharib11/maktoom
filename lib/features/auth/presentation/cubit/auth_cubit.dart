import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/user_dto.dart';
import '../../domain/repositories/auth_repository.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserDTO user;
  AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await _repository.login(email, password);
    
    if (result.isSuccess) {
      emit(AuthAuthenticated(result.data!));
    } else {
      emit(AuthError(result.error?.message ?? 'Login failed'));
    }
  }

  Future<void> register(String email, String password, String name) async {
    emit(AuthLoading());
    final result = await _repository.register(email, password, name);
    
    if (result.isSuccess) {
      // Typically login after registration or move to login
      emit(AuthUnauthenticated()); 
    } else {
      emit(AuthError(result.error?.message ?? 'Registration failed'));
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    emit(AuthUnauthenticated());
  }

  Future<void> checkAuthStatus() async {
    final user = await _repository.getCurrentUser();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
