import 'package:flutter/material.dart';

class HourlyForecastItemWidget extends StatelessWidget {
  final String hour;
  final bool isCurrentHour;
  final double tempC;
  final double tempF;
  final String icon;
  const HourlyForecastItemWidget(this.hour, this.tempC, this.tempF, this.icon,
      {this.isCurrentHour = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: isCurrentHour
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            )
          : const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(hour),
          Expanded(
            child: Image.asset(icon),
          ),
          Text("$tempC°"),
        ],
      ),
    );
  }
}
