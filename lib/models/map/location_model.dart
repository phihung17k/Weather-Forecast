import '../../log.dart';

class LocationModel {
  final String? name; //name
  final String? region; //region
  final String? country; //country
  //Latitude in decimal degree
  final double? lat; //lat
  //Longitude in decimal degree
  final double? lon; //lon
  //Time zone
  final String? tzId; //tz_id
  //Local date and time
  final String? localtime; //localtime

  LocationModel(
      {this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      this.tzId,
      this.localtime});

  factory LocationModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("LocationModel json is null");
    }
    return LocationModel(
      name: json!['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
      tzId: json['tz_id'],
      localtime: json['localtime'],
    );
  }
}
