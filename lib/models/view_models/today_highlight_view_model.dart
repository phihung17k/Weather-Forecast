import 'package:equatable/equatable.dart';

class TodayHighlightViewModel extends Equatable {
  final double? uvIndex;
  final double? windKph;
  final String? windDirection;
  final String? sunrise;
  final String? sunset;
  final int? humidity;
  final double? visibilityKm;
  final int? airQualityIndex;

  const TodayHighlightViewModel(
      {this.uvIndex,
      this.windKph,
      this.windDirection,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.visibilityKm,
      this.airQualityIndex});

  @override
  List<Object?> get props => [
        uvIndex,
        windKph,
        windDirection,
        sunrise,
        sunset,
        humidity,
        visibilityKm,
        airQualityIndex
      ];
}
