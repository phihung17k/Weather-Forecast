import 'package:equatable/equatable.dart';

class WeatherHeadingViewModel extends Equatable {
  final String? icon;
  final String? localTime;
  final double? tempC;
  final double? tempF;
  final String? weatherConditionText;

  const WeatherHeadingViewModel(
      {this.icon,
      this.localTime,
      this.tempC,
      this.tempF,
      this.weatherConditionText});

  @override
  List<Object?> get props =>
      [icon, localTime, tempC, tempF, weatherConditionText];
}
