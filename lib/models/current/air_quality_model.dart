import '../../log.dart';

class AirQualityModel {
  //Carbon Monoxide (μg/m3)
  final double? co; //co
  //Ozone (μg/m3)
  final double? o3; //o3
  //Nitrogen dioxide (μg/m3)
  final double? no2; //no2
  //Sulphur dioxide (μg/m3)
  final double? so2; //so2
  //PM2.5 (μg/m3)
  final double? pm2_5; //pm2_5
  //PM10 (μg/m3)
  final double? pm10; //pm10
  ///US - EPA standard
  final int? index; //us-epa-index

  AirQualityModel(
      {this.co,
      this.o3,
      this.no2,
      this.so2,
      this.pm2_5,
      this.pm10,
      this.index});

  factory AirQualityModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("AirQualityModel json is null");
    }
    return AirQualityModel(
      co: json!['co'],
      o3: json['o3'],
      no2: json['no2'],
      so2: json['so2'],
      pm2_5: json['pm2_5'],
      pm10: json['pm10'],
      index: json['us-epa-index'],
    );
  }
}
