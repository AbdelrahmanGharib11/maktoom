import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

@LazySingleton()
class AuthListenable extends ChangeNotifier {
  final AuthCubit _authCubit;

  AuthListenable(this._authCubit) {
    _authCubit.stream.listen((state) {
      notifyListeners();
    });
  }

  AuthState get state => _authCubit.state;
}
