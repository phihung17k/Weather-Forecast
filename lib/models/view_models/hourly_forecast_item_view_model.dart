import 'package:equatable/equatable.dart';

class HourlyForecastItemViewModel extends Equatable {
  final String? time;
  final String? icon;
  final double? tempC;
  final double? tempF;

  const HourlyForecastItemViewModel(
      {this.time, this.icon, this.tempC, this.tempF});

  @override
  List<Object?> get props => [time, icon, tempC, tempF];
}
