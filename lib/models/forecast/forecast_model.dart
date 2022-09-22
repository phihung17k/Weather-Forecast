import '../../log.dart';
import 'forecast_day/forecast_day_model.dart';

class ForecastModel {
  final List<ForecastDayModel>? forecastDays; //forecastday

  ForecastModel({this.forecastDays});

  factory ForecastModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("ForecastModel json is null");
    }
    List<dynamic> forecastDaysJson = json!['forecastday'];
    List<ForecastDayModel> forecastDays = forecastDaysJson
        .map<ForecastDayModel>((e) => ForecastDayModel.fromJson(e))
        .toList();

    return ForecastModel(forecastDays: forecastDays);
  }
}
