import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_forecast/bloc/map/map_state.dart';
import 'package:weather_forecast/pages/map/map_layers/map_layer_item_widget.dart';
import 'package:weather_forecast/pages/map/map_layers/map_layers_widget.dart';

import '../../bloc/map/map_bloc.dart';
import '../../bloc/map/map_event.dart';
import '../../global/app_themes.dart';
import '../../global/bloc/theme_bloc.dart';
import '../../utils.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapPage extends StatefulWidget {
  final MapBloc bloc;
  const MapPage(this.bloc, {super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {
  MapBloc get bloc => widget.bloc;

  GoogleMapController? mapController;

  // LatLng _center = const LatLng(20.656514, 106.239045);
  AnimationController? animationController;
  List animation = [];
  // bool isDisplayed = false;
  // StreamController<bool>? _displayController;
  // MapType mapType = MapType.normal;
  // Marker? marker;
  TextEditingController? _editingController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    for (int i = 0; i < 3; i++) {
      animation.add(Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animationController!,
          curve: Interval(0.2 * i, 1.0, curve: Curves.easeOutSine))));
    }

    _editingController = TextEditingController();
    // _displayController = StreamController();
    // _displayController!.stream.listen(
    //   (event) {
    //     setState(() {
    //       isDisplayed = !isDisplayed;
    //     });
    //   },
    // );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      String location = settings.arguments as String;
      // Log.d("push location to map: $location");
      bloc.add(GetInitialLocationEvent(location));
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context, listen: true);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
          BlocBuilder<MapBloc, MapState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is! MapLoadingState && state.currentPosition != null) {
                return GoogleMap(
                  onMapCreated: (controller) => mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: state.currentPosition!,
                    zoom: 15.0,
                  ),
                  mapType: state.mapType ?? MapType.normal,
                  markers: state.selectedPosition == null
                      ? {}
                      : {state.selectedPosition!},
                  onTap: (position) {
                    bloc.add(SelectingPositionEvent(position));
                  },
                  zoomGesturesEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          BlocBuilder<MapBloc, MapState>(
            bloc: bloc,
            builder: (context, state) {
              return state.selectedPosition != null
                  ? Positioned(
                      width: MediaQuery.of(context).size.width,
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text("Select here"),
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(bloc.state.selectedPosition);
                            },
                          ),
                        ],
                      ))
                  : const SizedBox();
            },
          ),
          Positioned(
              left: 10,
              bottom: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MapLayersWidget(
                    appLocalizations,
                    onPress: () {
                      if (bloc.state.isDisplayedMapLayers!) {
                        animationController!.forward();
                      } else {
                        animationController!.reverse();
                      }
                      bloc.add(UpdatingDisplayMapLayerEvent());
                    },
                  ),
                  for (int i = 0; i < 3; i++)
                    ScaleTransition(
                        scale: animation[i],
                        child: MapLayerItemWidget(
                          appLocalizations,
                          index: i,
                          onPress: () {
                            bloc.add(ChangeMapTypeEvent(i));
                          },
                        )),
                ],
              )),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(30),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _editingController,
                    decoration: InputDecoration(
                      hintText: appLocalizations.search_location,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.only(left: 20),
                      fillColor: themeBloc.state.themeData ==
                              appThemeData[AppTheme.dark]
                          ? Colors.grey
                          : Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      prefixIcon: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Image.asset(
                              "${StringUtils.imagePath}/google-maps.png")),
                      prefixIconConstraints:
                          const BoxConstraints(maxHeight: 25, maxWidth: 50),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    //get suggest
                    if (pattern.isNotEmpty) {
                      return await bloc.service.getSuggestingLocations(pattern);
                    }
                    return [];
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: const Icon(Icons.location_on_outlined),
                      title: Text(suggestion.description!),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    _editingController!.text = suggestion.description!;
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                if (bloc.state.currentPosition != null) {
                  LatLng position = bloc.state.currentPosition!;
                  mapController!.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      bearing: 0,
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 17.0,
                    ),
                  ));
                }
              },
              child: Icon(
                Icons.my_location,
                color: Colors.blue[800],
              ),
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() async {
    mapController?.dispose();
    super.dispose();
  }
}


// _showOverLay() async {
  //   streamController!.sink.add(isDisplayed);
  //   if (isDisplayed) {
  //     RenderBox? renderBox =
  //         globalKey.currentContext!.findRenderObject() as RenderBox?;
  //     Offset offset = renderBox!.localToGlobal(Offset.zero);
  //     OverlayState? overlayState = Overlay.of(context);
  //     overlayEntry = OverlayEntry(
  //         builder: (context) => 
  //         // Positioned(
  //         //     left: offset.dx,
  //         //     top: renderBox.size.height + 10,
  //         //     // top: 100,
  //         //     child: Column(
  //         //       mainAxisSize: MainAxisSize.min,
  //         //       children: [
  //         //         ScaleTransition(
  //         //             scale: animation[0], child: MapLayerItemWidget()),
  //         //         ScaleTransition(
  //         //             scale: animation[1], child: MapLayerItemWidget()),
  //         //         ScaleTransition(
  //         //             scale: animation[2], child: MapLayerItemWidget())
  //         //       ],
  //         //     )),
  //         );
  //     animationController!.addListener(() {
  //       overlayState!.setState(() {});
  //     });
  //     // print("true");
  //     animationController!.forward();
  //     overlayState!.insert(overlayEntry!);
  //   } else {
  //     // print("false");
  //     await Future.value(1)
  //         .whenComplete(() => animationController!.reverse())
  //         .whenComplete(() => overlayEntry!.remove());
  //     // animationController!.reverse();
  //     // overlayEntry!.remove();
  //   }
  //   // await Future.delayed(const Duration(seconds: 5))
  //   //     .whenComplete(() => animationController!.reverse())
  //   //     .whenComplete(() => overlayEntry!.remove());
  // }

  