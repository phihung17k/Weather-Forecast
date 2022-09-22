import 'package:weather_forecast/models/weather_forecast_today_model.dart';

abstract class IHomeService {
  Future<WeatherForecastTodayModel?> getWeatherForecastToday(String location);
}
