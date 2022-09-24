import 'package:weather_forecast/log.dart';
import 'package:weather_forecast/models/map/address_component_model.dart';

class AddressesModel {
  final List<AddressComponentModel>? addressComponents;

  AddressesModel({this.addressComponents});

  factory AddressesModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("AddressesModel json is null");
    }
    List<dynamic> addressComponentsJson = json!['address_components'];
    return AddressesModel(
        addressComponents: addressComponentsJson
            .map<AddressComponentModel>((e) =>
                AddressComponentModel.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
