import 'package:weather_forecast/models/weather_forecast_today_model.dart';

import '../../models/map/address_component_model.dart';

abstract class IHomeService {
  Future<WeatherForecastTodayModel?> getWeatherForecastToday(String location);
  Future<List<AddressComponentModel>> getAddressInformation(
      double latitude, double longitude);
}
