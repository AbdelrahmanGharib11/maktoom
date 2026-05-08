import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:maktoom/features/auth/domain/repositories/auth_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repositories/therapist_repository.dart';
import '../models/therapist_dto.dart';

@LazySingleton(as: TherapistRepository)
class TherapistRepositoryImpl implements TherapistRepository {
  final Dio _dio;

  TherapistRepositoryImpl(this._dio);

  @override
  Future<Result<List<TherapistDTO>, Failure>> getTherapists({
    String? category,
    String? query,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.therapists,
        queryParameters: {
          if (category != null) 'category': category,
          if (query != null) 'query': query,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final List list = response.data['data'];
        final therapists = list.map((e) => TherapistDTO.fromJson(e)).toList();
        return Result.success(therapists);
      }
      return Result.failure(const ServerFailure('Failed to load therapists'));
    } on DioException catch (e) {
      return Result.failure(ServerFailure(e.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Result<TherapistDTO, Failure>> getTherapistDetails(String id) async {
    try {
      final response = await _dio.get('${ApiEndpoints.therapistDetails}$id');
      if (response.statusCode == 200) {
        return Result.success(TherapistDTO.fromJson(response.data));
      }
      return Result.failure(const ServerFailure('Therapist not found'));
    } on DioException catch (e) {
      return Result.failure(ServerFailure(e.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Result<void, Failure>> toggleFavorite(String id) async {
    try {
      await _dio.post('${ApiEndpoints.therapists}/$id/favorite');
      return Result.success(null);
    } on DioException catch (e) {
      return Result.failure(ServerFailure(e.message ?? 'Action failed'));
    }
  }
}
