import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

final ThemeData lightTheme = ThemeData.light();
final ThemeData darkTheme = ThemeData.dark();

class ThemeCubit extends HydratedCubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  void toggleTheme() {
    emit(state.brightness == Brightness.light ? darkTheme : lightTheme);
  }

  @override
  ThemeData fromJson(Map<String, dynamic> json) {
    return json['isDark'] as bool ? darkTheme : lightTheme;
  }

  @override
  Map<String, dynamic> toJson(ThemeData state) {
    return {'isDark': state.brightness == Brightness.dark};
  }
}