import '../../../log.dart';

class AstroModel {
  final String? sunrise; //sunrise
  final String? sunset; //sunset
  final String? moonrise; //moonrise
  final String? moonset; //moonset
  //Moon phases. Value returned:
  //- New Moon
  //- Waxing Crescent
  //- First Quarter
  //- Waxing Gibbous
  //- Full Moon
  //- Waning Gibbous
  //- Last Quarter
  //- Waning Crescent
  final String? moonPhase; //moon_phase
  //Moon illumination as %
  final double? moonIllumination; //moon_illumination

  AstroModel(
      {this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.moonIllumination});

  factory AstroModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("AstroModel json is null");
    }
    return AstroModel(
      sunrise: json!['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: json['moon_phase'],
      moonIllumination: double.tryParse(json['moon_illumination']),
    );
  }
}
