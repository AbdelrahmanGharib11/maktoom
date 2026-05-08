import 'package:maktoom/features/auth/domain/repositories/auth_repository.dart';
import 'package:maktoom/features/therapists/data/models/therapist_dto.dart';

import '../../../../core/error/failures.dart';

abstract class TherapistRepository {
  Future<Result<List<TherapistDTO>, Failure>> getTherapists({
    String? category,
    String? query,
    int page = 1,
  });

  Future<Result<TherapistDTO, Failure>> getTherapistDetails(String id);

  Future<Result<void, Failure>> toggleFavorite(String id);
}
