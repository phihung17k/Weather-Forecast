import '../../../log.dart';
import '../../condition_weather_model.dart';

class DayModel {
  //Maximum temperature in celsius for the day.
  final double? maxTempC; //maxtemp_c
  //Maximum temperature in fahrenheit for the day
  final double? maxTempF; //maxtemp_f
  //Minimum temperature in celsius for the day
  final double? minTempC; //mintemp_c
  //Minimum temperature in fahrenheit for the day
  final double? minTempF; //mintemp_f
  //Average temperature in celsius for the day
  final double? avgTempC; //avgtemp_c
  //Average temperature in fahrenheit for the day
  final double? avgTempF; //avgtemp_f
  //Maximum wind speed in kilometer per hour
  final double? maxWindKph; //maxwind_kph
  //Total precipitation in milimeter
  final double? totalPrecipMM; //totalprecip_mm
  //Average visibility in kilometer
  final double? avgVisKm; // avgvis_km
  //Average humidity as percentage
  final double? avgHumidity; //avghumidity
  //Weather condition
  final ConditionWeatherModel? condition; //condition
  //UV Index
  final double? uv; //uv

  DayModel(
      {this.maxTempC,
      this.maxTempF,
      this.minTempC,
      this.minTempF,
      this.avgTempC,
      this.avgTempF,
      this.maxWindKph,
      this.totalPrecipMM,
      this.avgVisKm,
      this.avgHumidity,
      this.condition,
      this.uv});

  factory DayModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("DayModel json is null");
    }
    return DayModel(
      maxTempC: json!['maxtemp_c'],
      maxTempF: json['maxtemp_f'],
      minTempC: json['mintemp_c'],
      minTempF: json['mintemp_f'],
      avgTempC: json['avgtemp_c'],
      avgTempF: json['avgtemp_f'],
      maxWindKph: json['maxwind_kph'],
      totalPrecipMM: json['totalprecip_mm'],
      avgVisKm: json['avgvis_km'],
      avgHumidity: json['avghumidity'],
      condition: ConditionWeatherModel.fromJson(json['condition']),
      uv: json['uv'],
    );
  }
}
