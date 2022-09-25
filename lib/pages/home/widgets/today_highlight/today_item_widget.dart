import 'package:flutter/material.dart';
import 'package:weather_forecast/enums.dart';

import 'air_quality_widget.dart';
import 'humidity_widget.dart';
import 'sun_status_widget.dart';
import 'uv_index_widget.dart';
import 'visibility_widget.dart';
import 'wind_status_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodayItemWidget extends StatefulWidget {
  final GlobalKey widgetKey = GlobalKey();
  final TodayItemEnum item;

  TodayItemWidget(this.item, {super.key});

  @override
  State<TodayItemWidget> createState() => _TodayItemWidgetState();
}

class _TodayItemWidgetState extends State<TodayItemWidget> {
  TodayItemEnum get item => widget.item;
  GlobalKey get _widgetKey => widget.widgetKey;
  double width = 0;
  // double height = 0;

  String getTitle(TodayItemEnum item, AppLocalizations appLocalizations) {
    switch (item) {
      case TodayItemEnum.uvIndex:
        return appLocalizations.uv_index;
      case TodayItemEnum.windStatus:
        return appLocalizations.wind_status;
      case TodayItemEnum.sunStatus:
        return appLocalizations.sunrise_and_sunset;
      case TodayItemEnum.humidity:
        return appLocalizations.humidity;
      case TodayItemEnum.visibility:
        return appLocalizations.visibility;
      case TodayItemEnum.airQuality:
        return appLocalizations.air_quality;
    }
  }

  Widget getInformation(TodayItemEnum item, AppLocalizations appLocalizations) {
    switch (item) {
      case TodayItemEnum.uvIndex:
        return UVIndexWidget(width);
      case TodayItemEnum.windStatus:
        return WindStatusWidget(appLocalizations);
      case TodayItemEnum.sunStatus:
        return const SunStatusWidget();
      case TodayItemEnum.humidity:
        return HumidityWidget(appLocalizations);
      case TodayItemEnum.visibility:
        return VisibilityWidget(appLocalizations);
      case TodayItemEnum.airQuality:
        return AirQualityWidget(appLocalizations);
      default:
        return const SizedBox(
          width: 200,
          height: 80,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var renderBox =
          _widgetKey.currentContext?.findRenderObject() as RenderBox?;
      // print("renderBox ${renderBox?.size.width}");
      if (renderBox != null) {
        width = renderBox.size.width;
        // height = renderBox.size.height;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        key: _widgetKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 18, top: 10),
            height: 52,
            child: Text(getTitle(item, appLocalizations)),
          ),
          SizedBox(
              width: 200,
              height: 80,
              child: getInformation(item, appLocalizations)),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
