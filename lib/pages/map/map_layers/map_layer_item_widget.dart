import 'package:flutter/material.dart';

import '../../../utils.dart';

class MapLayerItemWidget extends StatelessWidget {
  final int index;
  final Function()? onPress;

  MapLayerItemWidget({
    Key? key,
    this.index = 0,
    this.onPress,
  }) : super(key: key);

  final List<String> titles = ["Default", "Satellite", "Terrain"];
  final List<String> mapIcons = [
    "map_default.png",
    "map_satellite.png",
    "map_terrain.png"
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 60,
        height: 80,
        margin: const EdgeInsets.only(left: 5),
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Colors.grey,
                offset: Offset(5, 5),
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("${StringUtils.imagePath}/${mapIcons[index]}"),
            SizedBox(
              height: 5,
            ),
            Text(titles[index])
          ],
        ),
      ),
    );
    // FloatingActionButton.extended(
    //   onPressed: () {},
    //   icon: Image.asset("${StringUtils.imagePath}/map_satellite.png"),
    //   label: Text("abvc"),
    // );

    // return Container(
    //   width: 80,
    //   height: 80,
    //   // color: Colors.transparent,
    //   child: Scaffold(
    //     backgroundColor: Colors.transparent,
    //     body: Container(
    //       // width: 50,
    //       // height: 50,
    //       padding: const EdgeInsets.all(5),
    //       decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(10),
    //           boxShadow: const [
    //             BoxShadow(
    //               blurRadius: 10,
    //               color: Colors.grey,
    //               offset: Offset(5, 5),
    //             )
    //           ]),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Image.asset("${StringUtils.imagePath}/satellite_view.webp"),
    //           Text("Map layers")
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
