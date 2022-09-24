import 'package:weather_forecast/models/map/address_component_model.dart';
import 'package:weather_forecast/models/map/addresses_model.dart';

import '../api.dart';
import '../log.dart';
import '../models/prediction/prediction_model.dart';
import 'interface/i_map_service.dart';
import 'service_adaptor.dart';
import 'package:http/http.dart' as http;

class MapService implements IMapService {
  final ServiceAdaptor _adaptor = ServiceAdaptor();

  @override
  Future<List<PredictionModel>> getSuggestingLocations(
      String searchedValue) async {
    var client = http.Client();
    String url = Api.getSuggestingLocationsURL(searchedValue);
    Log.d("URL $url");
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = _adaptor.parseToMap(response);
        List<dynamic> predictionsJson = json!['predictions'];
        List<PredictionModel> result = predictionsJson
            .map<PredictionModel>((e) => PredictionModel.fromJson(e))
            .toList();
        return result;
      }
    } catch (e) {
      Log.e(e.toString());
    } finally {
      client.close();
    }
    return [];
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
