import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/global/app_themes.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: appThemeData[AppTheme.light])) {
    on<ChangingThemeEvent>(changeTheme);
  }

  FutureOr<void> changeTheme(
      ChangingThemeEvent event, Emitter<ThemeState> emitter) async {
    emitter.call(state.copyWith(themeData: appThemeData[event.newTheme]));
  }
}
