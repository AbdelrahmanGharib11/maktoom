import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../network/api_endpoints.dart';
import '../network/auth_interceptor.dart';

@module
abstract class CoreModule {
  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      authInterceptor,
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);

    return dio;
  }

  @lazySingleton
  FlutterSecureStorage get storage => const FlutterSecureStorage();
}
