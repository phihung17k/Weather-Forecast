import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_forecast/pages/map/map_layers/map_layer_item_widget.dart';
import 'package:weather_forecast/pages/map/map_layers/map_layers_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {
  GoogleMapController? mapController;

  LatLng _center = const LatLng(20.656514, 106.239045);
  AnimationController? animationController;
  List animation = [];
  bool isDisplayed = false;
  StreamController<bool>? _displayController;
  MapType mapType = MapType.normal;
  Marker? marker;

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

    _displayController = StreamController();
    _displayController!.stream.listen(
      (event) {
        setState(() {
          isDisplayed = !isDisplayed;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            mapType: mapType,
            myLocationEnabled: true,
            markers: marker == null ? {} : {marker!},
            onTap: (position) {
              setState(() {
                marker = Marker(
                    markerId:
                        MarkerId("${position.latitude} ${position.longitude}"),
                    position: LatLng(position.latitude, position.longitude));
              });
            },
            zoomGesturesEnabled: true,
          ),
          if (marker != null)
            Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text("Select here"),
                      onPressed: () {
                        Navigator.of(context).pop(marker);
                      },
                    ),
                  ],
                )),
          Positioned(
              left: 10,
              bottom: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MapLayersWidget(
                    // key: globalKey,
                    onPress: () {
                      if (!isDisplayed) {
                        animationController!.forward();
                      } else {
                        animationController!.reverse();
                      }
                      _displayController!.sink.add(isDisplayed);
                    },
                  ),
                  for (int i = 0; i < 3; i++)
                    ScaleTransition(
                        scale: animation[i],
                        child: MapLayerItemWidget(
                          index: i,
                          onPress: () {
                            if (i == 0 && mapType != MapType.normal) {
                              setState(() {
                                mapType = MapType.normal;
                              });
                            } else if (i == 1 && mapType != MapType.hybrid) {
                              setState(() {
                                mapType = MapType.hybrid;
                              });
                            } else if (i == 2 && mapType != MapType.terrain) {
                              setState(() {
                                mapType = MapType.terrain;
                              });
                            }
                          },
                        )),
                ],
              )),
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

  