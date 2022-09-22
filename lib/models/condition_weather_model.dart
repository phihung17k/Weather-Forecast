import '../log.dart';

class ConditionWeatherModel {
  final String? text; //text
  final String? icon; //icon
  final int? code; //code

  ConditionWeatherModel({this.text, this.icon, this.code});

  factory ConditionWeatherModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("WeatherForecastTodayModel json is null");
    }
    return ConditionWeatherModel(
        text: json!['text'], icon: json['icon'], code: json['code']);
  }
}
