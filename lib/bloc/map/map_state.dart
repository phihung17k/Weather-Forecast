import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState extends Equatable {
  final LatLng? currentPosition;
  final bool? isDisplayedMapLayers;
  final MapType? mapType;
  final Marker? selectedPosition;

  const MapState(
      {this.currentPosition,
      this.isDisplayedMapLayers = true,
      this.mapType = MapType.normal,
      this.selectedPosition});

  MapState copyWith(
      {LatLng? currentPosition,
      bool? isDisplayedMapLayers,
      MapType? mapType,
      Marker? selectedPosition}) {
    return MapState(
        currentPosition: currentPosition ?? this.currentPosition,
        isDisplayedMapLayers: isDisplayedMapLayers ?? this.isDisplayedMapLayers,
        mapType: mapType ?? this.mapType,
        selectedPosition: selectedPosition ?? this.selectedPosition);
  }

  @override
  List<Object?> get props =>
      [currentPosition, isDisplayedMapLayers, mapType, selectedPosition];
}

class MapLoadingState extends MapState {}
