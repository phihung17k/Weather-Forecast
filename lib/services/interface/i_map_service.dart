import 'package:weather_forecast/models/map/address_component_model.dart';
import 'package:weather_forecast/models/prediction/prediction_model.dart';

abstract class IMapService {
  Future<List<PredictionModel>> getSuggestingLocations(String searchedValue);
  Future<List<AddressComponentModel>> getAddressInformation(
      double latitude, double longitude);
}
