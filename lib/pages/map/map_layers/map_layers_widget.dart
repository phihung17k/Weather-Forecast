import 'package:flutter/material.dart';

class MapLayersWidget extends StatelessWidget {
  final Function()? onPress;

  const MapLayersWidget({
    Key? key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 60,
        height: 80,
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
          children: const [
            Expanded(
              child: Icon(
                Icons.layers_outlined,
                size: 30,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Layers")
          ],
        ),
      ),
    );
  }
}
