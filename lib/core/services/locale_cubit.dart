import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  void setLocale(Locale locale) {
    if (state == locale) return;
    emit(locale);
  }

  void toggleLocale() {
    if (state.languageCode == 'en') {
      emit(const Locale('ar'));
    } else {
      emit(const Locale('en'));
    }
  }
}
