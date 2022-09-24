import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_forecast/bloc/map/map_event.dart';
import 'package:weather_forecast/bloc/map/map_state.dart';
import 'package:weather_forecast/models/map/address_component_model.dart';
import 'package:weather_forecast/services/services.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final IMapService service;
  MapBloc(this.service) : super(const MapState()) {
    on<GetInitialLocationEvent>(initCameraPosition);
    on<UpdatingDisplayMapLayerEvent>(updateDislayMapLayer);
    on<ChangeMapTypeEvent>(changeMapType);
    on<SelectingPositionEvent>(selectPosition);
  }

  FutureOr<void> initCameraPosition(
      GetInitialLocationEvent event, Emitter<MapState> emitter) {
    emitter.call(MapLoadingState());
    List<String> coordinates = event.location.split(' ');
    double lat = double.tryParse(coordinates[0]) ?? 20;
    double lon = double.tryParse(coordinates[1]) ?? 100;
    emitter.call(state.copyWith(currentPosition: LatLng(lat, lon)));
  }

  FutureOr<void> updateDislayMapLayer(
      UpdatingDisplayMapLayerEvent event, Emitter<MapState> emitter) {
    emitter.call(
        state.copyWith(isDisplayedMapLayers: !state.isDisplayedMapLayers!));
  }

  FutureOr<void> changeMapType(
      ChangeMapTypeEvent event, Emitter<MapState> emitter) {
    int typeIndex = event.typeIndex;
    if (typeIndex == 0 && state.mapType != MapType.normal) {
      emitter.call(state.copyWith(mapType: MapType.normal));
    } else if (typeIndex == 1 && state.mapType != MapType.hybrid) {
      emitter.call(state.copyWith(mapType: MapType.hybrid));
    } else if (typeIndex == 2 && state.mapType != MapType.terrain) {
      emitter.call(state.copyWith(mapType: MapType.terrain));
    }
  }

  FutureOr<void> selectPosition(
      SelectingPositionEvent event, Emitter<MapState> emitter) async {
    LatLng position = event.position;
    //get and filter address string
    List<AddressComponentModel> addressComponents = await service
        .getAddressInformation(position.latitude, position.longitude);
    //remove address component if its type is plus_code: M64Q+FMJ
    addressComponents.removeWhere(
        (addressComponent) => addressComponent.types!.contains("plus_code"));
    String titleMarker = addressComponents.join(', ');

    Marker marker = Marker(
      markerId: MarkerId("${position.latitude} ${position.longitude}"),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: InfoWindow(title: titleMarker),
    );
    emitter(state.copyWith(selectedPosition: marker));
  }
}
