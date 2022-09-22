import '../../../log.dart';
import 'astro_model.dart';
import 'day_model.dart';
import 'hour_model.dart';

class ForecastDayModel {
  //Forecast date
  final String? date; //date
  final DayModel? day; //day
  final AstroModel? astro; //astro
  final List<HourModel>? hours;

  ForecastDayModel({this.date, this.day, this.astro, this.hours});

  factory ForecastDayModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      Log.e("ForecastDayModel json is null");
    }
    // List<HourModel> hours = [];
    List<dynamic> hoursJson = json!['hour'];
    // for (var item in hoursJson) {
    //   HourModel hour = HourModel.fromJson(item);
    //   hours.add(hour);
    // }
    List<HourModel> hours =
        hoursJson.map<HourModel>((hour) => HourModel.fromJson(hour)).toList();

    return ForecastDayModel(
        date: json['date'],
        day: DayModel.fromJson(json['day']),
        astro: AstroModel.fromJson(json['astro']),
        hours: hours);
  }
}
