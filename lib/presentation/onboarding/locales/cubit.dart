import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:storage/main.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit({
    required this.localeProvider,
  }) : super(Locale('en')) {
    // TODO(Filippo): uncomment the below
    // _getLocaleFromPrefs();
  }

  final LocaleProviderInterface localeProvider;

  Future<void> saveLocaleToPrefs({required Locale locale}) async {
    localeProvider.writeLocaleToPrefs(locale.languageCode);
    emit(locale);
  }

  Future<void> _getLocaleFromPrefs() async {
    final String? languageCode = await localeProvider.readLocaleFromPrefs();
    if (languageCode != null) {
      emit(Locale(languageCode));
    }
  }
}
