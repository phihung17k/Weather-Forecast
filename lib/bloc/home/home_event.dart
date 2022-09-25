import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class HomeEvent {}

class InitialDataEvent extends HomeEvent {}

class WeatherForecastUpdationEvent extends HomeEvent {
  final Marker? marker;

  WeatherForecastUpdationEvent(this.marker);
}

class RefreshDataEvent extends HomeEvent {}
