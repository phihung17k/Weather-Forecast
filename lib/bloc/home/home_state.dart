import 'package:equatable/equatable.dart';
import '../../models/view_models/hourly_forecast_item_view_model.dart';
import '../../models/view_models/today_highlight_view_model.dart';
import '../../models/view_models/weather_heading_view_model.dart';

class HomeState extends Equatable {
  final String? locationCoordinate; //"lat lon"
  final String? locationName;
  final WeatherHeadingViewModel? weatherHeading;
  final TodayHighlightViewModel? todayHighLight;
  final List<HourlyForecastItemViewModel>? hourlyForecasts;

  const HomeState(
      {this.locationCoordinate,
      this.locationName,
      this.weatherHeading,
      this.todayHighLight,
      this.hourlyForecasts});

  HomeState copyWith(
      {String? locationCoordinate,
      String? locationName,
      WeatherHeadingViewModel? weatherHeading,
      TodayHighlightViewModel? todayHighLight,
      List<HourlyForecastItemViewModel>? hourlyForecasts}) {
    return HomeState(
        locationCoordinate: locationCoordinate ?? this.locationCoordinate,
        locationName: locationName ?? this.locationName,
        weatherHeading: weatherHeading ?? this.weatherHeading,
        todayHighLight: todayHighLight ?? this.todayHighLight,
        hourlyForecasts: hourlyForecasts ?? this.hourlyForecasts);
  }

  @override
  List<Object?> get props => [
        locationCoordinate,
        locationName,
        weatherHeading,
        todayHighLight,
        hourlyForecasts
      ];
}

class HomeLoadingState extends HomeState {}
