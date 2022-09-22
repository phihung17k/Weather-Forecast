import '../log.dart';
import 'current/current_model.dart';
import 'forecast/forecast_model.dart';
import 'location/location_model.dart';

class WeatherForecastTodayModel {
  final LocationModel? location; //location
  final CurrentModel? current; //current
  final ForecastModel? forecast; //forecast

  WeatherForecastTodayModel({this.location, this.current, this.forecast});

  factory WeatherForecastTodayModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("WeatherForecastTodayModel json is null");
    }
    return WeatherForecastTodayModel(
      location: LocationModel.fromJson(json!['location']),
      current: CurrentModel.fromJson(json['current']),
      forecast: ForecastModel.fromJson(json['forecast']),
    );
  }
}
