// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:maktoom/core/di/core_module.dart' as _i737;
import 'package:maktoom/core/network/auth_interceptor.dart' as _i1032;
import 'package:maktoom/core/services/auth_listenable.dart' as _i412;
import 'package:maktoom/core/services/locale_cubit.dart' as _i574;
import 'package:maktoom/features/auth/data/repositories/auth_repository_impl.dart'
    as _i750;
import 'package:maktoom/features/auth/domain/repositories/auth_repository.dart'
    as _i184;
import 'package:maktoom/features/auth/presentation/cubit/auth_cubit.dart'
    as _i995;
import 'package:maktoom/features/therapists/data/repositories/therapist_repository_impl.dart'
    as _i274;
import 'package:maktoom/features/therapists/domain/repositories/therapist_repository.dart'
    as _i537;
import 'package:maktoom/features/therapists/presentation/cubit/therapists_cubit.dart'
    as _i210;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModule = _$CoreModule();
    gh.factory<_i574.LocaleCubit>(() => _i574.LocaleCubit());
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => coreModule.storage);
    gh.lazySingleton<_i1032.AuthInterceptor>(
        () => _i1032.AuthInterceptor(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i361.Dio>(
        () => coreModule.dio(gh<_i1032.AuthInterceptor>()));
    gh.lazySingleton<_i537.TherapistRepository>(
        () => _i274.TherapistRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i184.AuthRepository>(() => _i750.AuthRepositoryImpl(
          gh<_i361.Dio>(),
          gh<_i558.FlutterSecureStorage>(),
        ));
    gh.factory<_i210.TherapistsCubit>(
        () => _i210.TherapistsCubit(gh<_i537.TherapistRepository>()));
    gh.factory<_i995.AuthCubit>(
        () => _i995.AuthCubit(gh<_i184.AuthRepository>()));
    gh.lazySingleton<_i412.AuthListenable>(
        () => _i412.AuthListenable(gh<_i995.AuthCubit>()));
    return this;
  }
}

class _$CoreModule extends _i737.CoreModule {}
