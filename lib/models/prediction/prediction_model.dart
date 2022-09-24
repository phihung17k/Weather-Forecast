import '../../log.dart';

class PredictionModel {
  final String? description;
  final String? placeId;

  PredictionModel({this.description, this.placeId});

  factory PredictionModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("Prediction Model json is null");
    }
    return PredictionModel(
        description: json!['description'], placeId: json['place_id']);
  }
}
