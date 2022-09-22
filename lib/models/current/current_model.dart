import '../../log.dart';
import '../condition_weather_model.dart';
import '../general_forecast_model.dart';
import 'air_quality_model.dart';

class CurrentModel extends GeneralForecastModel {
  //Local time when the real time data was updated
  final String? lastUpdated; //last_updated
  final AirQualityModel? airQualityModel; //air_quality

  CurrentModel({
    this.lastUpdated,
    double? tempC,
    double? tempF,
    bool? isDay,
    ConditionWeatherModel? condition,
    double? windKph,
    int? windDegree,
    String? windDirection,
    double? precipMM,
    int? humidity,
    int? cloud,
    double? feelslikeC,
    double? feelslikeF,
    double? visKm,
    double? gustKph,
    double? uv,
    this.airQualityModel,
  }) : super(
            tempC: tempC,
            tempF: tempF,
            isDay: isDay,
            condition: condition,
            windKph: windKph,
            windDegree: windDegree,
            windDirection: windDirection,
            precipMM: precipMM,
            humidity: humidity,
            cloud: cloud,
            feelslikeC: feelslikeC,
            feelslikeF: feelslikeF,
            visKm: visKm,
            gustKph: gustKph,
            uv: uv);

  factory CurrentModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("CurrentModel json is null");
    }
    return CurrentModel(
      lastUpdated: json!['last_updated'],
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      isDay: (json['is_day'] as int) == 1,
      condition: ConditionWeatherModel.fromJson(json['condition']),
      windKph: json['wind_kph'],
      windDegree: json['wind_degree'],
      windDirection: json['wind_dir'],
      precipMM: json['precip_mm'],
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'],
      feelslikeF: json['feelslike_f'],
      visKm: json['vis_km'],
      gustKph: json['gust_kph'],
      uv: json['uv'],
      airQualityModel: AirQualityModel.fromJson(json['air_quality']),
    );
  }
}
