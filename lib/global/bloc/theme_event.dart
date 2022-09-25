import '../app_themes.dart';

abstract class ThemeEvent {}

class ChangingThemeEvent extends ThemeEvent {
  final AppTheme? newTheme;

  ChangingThemeEvent({this.newTheme});
}
