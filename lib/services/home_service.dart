import 'package:http/http.dart' as http;

import '../api.dart';
import '../log.dart';
import '../models/map/address_component_model.dart';
import '../models/map/addresses_model.dart';
import '../models/weather_forecast_today_model.dart';
import 'interface/i_home_service.dart';
import 'service_adaptor.dart';

class HomeService implements IHomeService {
  final ServiceAdaptor _adaptor = ServiceAdaptor();

  @override
  Future<WeatherForecastTodayModel?> getWeatherForecastToday(
      String location) async {
    var client = http.Client();
    String key = '1994ae51466f4d659f083201212708';
    // String q = '20.65538 106.24046';
    int day = 1;
    String aqi = 'yes';
    String url = Api.getForecastURL(key, location, day, aqi);
    Log.d("URL $url");
    try {
      var response = await client.get(Uri.parse(url));
      Log.d("response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        var json = _adaptor.parseToMap(response);
        var result = WeatherForecastTodayModel.fromJson(json);
        return result;
      }
    } catch (e) {
      Log.e(e.toString());
    } finally {
      client.close();
    }
    return null;
  }

  @override
  Future<List<AddressComponentModel>> getAddressInformation(
      double latitude, double longitude) async {
    var client = http.Client();
    String url = Api.getGeocodingLocationURL(latitude, longitude);
    Log.d("URL $url");
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = _adaptor.parseToMap(response);
        List<dynamic> addressResults = json!['results'];
        var addresses =
            AddressesModel.fromJson(addressResults[0] as Map<String, dynamic>);
        return addresses.addressComponents ?? [];
      }
    } catch (e) {
      Log.e(e.toString());
    } finally {
      client.close();
    }
    return [];
  }
}
