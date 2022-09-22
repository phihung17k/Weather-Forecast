import 'condition_weather_model.dart';

///some general fields for reuse

abstract class GeneralForecastModel {
  //Temperature in celsius
  final double? tempC; //temp_c
  //Temperature in fahrenheit
  final double? tempF; //temp_f
  //json return int: 1 = Yes 0 = No
  final bool? isDay; //is_day
  //Weather condition
  final ConditionWeatherModel? condition; //condition
  //Wind speed in kilometer per hour
  final double? windKph; //wind_kph
  //Wind direction in degrees
  final int? windDegree; //wind_degree
  //Wind direction as 16 point compass. e.g.: NSW
  final String? windDirection; //wind_dir
  //Precipitation amount in millimeters
  final double? precipMM; //precip_mm
  //Humidity as percentage
  final int? humidity; //humidity
  //Cloud cover as percentage
  final int? cloud; //cloud
  //Feels like temperature as celcius
  final double? feelslikeC; //feelslike_c
  //Feels like temperature as fahrenheit
  final double? feelslikeF; //feelslike_f
  //Visibility in kilometer
  final double? visKm; //vis_km
  //Wind gust in kilometer per hour
  final double? gustKph; //gust_kph
  //UV Index
  final double? uv; //uv

  GeneralForecastModel(
      {this.tempC,
      this.tempF,
      this.isDay,
      this.condition,
      this.windKph,
      this.windDegree,
      this.windDirection,
      this.precipMM,
      this.humidity,
      this.cloud,
      this.feelslikeC,
      this.feelslikeF,
      this.visKm,
      this.gustKph,
      this.uv});
}
