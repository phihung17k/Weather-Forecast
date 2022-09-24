import 'package:weather_forecast/log.dart';

class AddressComponentModel {
  final String? longName; //long_name
  final List<String>?
      types; //plus_code, neighborhood, political, country and more.

  AddressComponentModel({this.longName, this.types});

  factory AddressComponentModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("AddressComponentModel json is null");
    }
    List<dynamic> typesJson = json!['types'];
    return AddressComponentModel(
        longName: json['long_name'],
        types: typesJson.map<String>((e) => e as String).toList());
  }

  @override
  String toString() {
    // TODO: implement toString
    return longName ?? "";
  }
}
