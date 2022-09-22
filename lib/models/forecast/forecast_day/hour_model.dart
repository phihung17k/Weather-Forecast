import '../../../log.dart';
import '../../condition_weather_model.dart';
import '../../general_forecast_model.dart';

class HourModel extends GeneralForecastModel {
  //Date and time
  final String? time; //time
  //Windchill temperature in celcius
  final double? windChillC; //windchill_c
  //Windchill temperature in fahrenheit
  final double? windChillF; //windchill_f
  //Heat index in celcius
  final double? heatIndexC; //heatindex_c
  //Heat index in fahrenheit
  final double? heatIndexF; //heatindex_f
  //Dew point in celcius
  final double? dewPointC; //dewpoint_c
  //Dew point in fahrenheit
  final double? dewPointF; //dewpoint_f
  //Will it will rain or not, 1 = Yes 0 = No
  final bool? willRain; //will_it_rain

  HourModel({
    this.time,
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
    this.windChillC,
    this.windChillF,
    this.heatIndexC,
    this.heatIndexF,
    this.dewPointC,
    this.dewPointF,
    this.willRain,
    double? visKm,
    double? gustKph,
    double? uv,
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

  factory HourModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("HourModel json is null");
    }
    return HourModel(
      time: json!['time'],
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
      windChillC: json['windchill_c'],
      windChillF: json['windchill_f'],
      heatIndexC: json['heatindex_c'],
      heatIndexF: json['heatindex_f'],
      dewPointC: json['dewpoint_c'],
      dewPointF: json['dewpoint_f'],
      willRain: (json['will_it_rain'] as int) == 1,
      visKm: json['vis_km'],
      gustKph: json['gust_kph'],
      uv: json['uv'],
    );
  }
}
