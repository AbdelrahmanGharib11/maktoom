import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/therapist_dto.dart';
import '../../domain/repositories/therapist_repository.dart';

abstract class TherapistsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TherapistsInitial extends TherapistsState {}

class TherapistsLoading extends TherapistsState {}

class TherapistsLoaded extends TherapistsState {
  final List<TherapistDTO> therapists;
  final String? selectedCategory;

  TherapistsLoaded(this.therapists, {this.selectedCategory});

  @override
  List<Object?> get props => [therapists, selectedCategory];
}

class TherapistsError extends TherapistsState {
  final String message;
  TherapistsError(this.message);

  @override
  List<Object?> get props => [message];
}

@injectable
class TherapistsCubit extends Cubit<TherapistsState> {
  final TherapistRepository _repository;

  TherapistsCubit(this._repository) : super(TherapistsInitial());

  Future<void> loadTherapists({String? category}) async {
    emit(TherapistsLoading());
    final result = await _repository.getTherapists(category: category);
    
    if (result.isSuccess) {
      emit(TherapistsLoaded(result.data!, selectedCategory: category));
    } else {
      emit(TherapistsError(result.error?.message ?? 'Failed to load therapists'));
    }
  }

  Future<void> selectCategory(String category) async {
    loadTherapists(category: category == 'All' ? null : category);
  }
}
