import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent {}

class GetInitialLocationEvent extends MapEvent {
  final String location;

  GetInitialLocationEvent(this.location);
}

class UpdatingDisplayMapLayerEvent extends MapEvent {}

class ChangeMapTypeEvent extends MapEvent {
  final int typeIndex; //0: normal, 1: hybrid, 2: terrain

  ChangeMapTypeEvent(this.typeIndex);
}

class SelectingPositionEvent extends MapEvent {
  final LatLng position;
  SelectingPositionEvent(this.position);
}

class MovingToMyLocation extends MapEvent {}
