import 'dart:convert';

import 'package:flutter/services.dart';

class StringUtils {
  static String get dayImagePath => "assets/images/weather/day";
  static String get weatherImagePath => "assets/images/weather";
  static String get imagePath => "assets/images";
  static String get constantPath => "assets/constants";

  //originAPI format "//cdn.weatherapi.com/weather/64x64/day/176.png"
  static String getWeatherIconPath(String originAPI) {
    int indexIcon = originAPI.indexOf(RegExp(r'(\/\w+\/\d+\.png)$'));
    String icon = originAPI.substring(indexIcon);
    String iconPath = "$weatherImagePath$icon";
    return iconPath;
  }
}

Map<String, String> weatherConditionEnMap = {};
Map<String, String> weatherConditionViMap = {};
Map<String, String> compassDirectionEnMap = {};
Map<String, String> compassDirectionViMap = {};

class FileUtils {
  static Future<void> readConstantsJson() async {
    //weather condition
    String weatherConditionEnJson = await rootBundle.loadString(
        "${StringUtils.constantPath}/weather_condition_text_en.json");
    Map<String, dynamic> tempWeatherConditionEnMap =
        jsonDecode(weatherConditionEnJson);
    weatherConditionEnMap = tempWeatherConditionEnMap
        .map((key, value) => MapEntry(key, value.toString()));

    String weatherConditionViJson = await rootBundle.loadString(
        "${StringUtils.constantPath}/weather_condition_text_vi.json");
    Map<String, dynamic> tempWeatherConditionViMap =
        jsonDecode(weatherConditionViJson);
    weatherConditionViMap = tempWeatherConditionViMap
        .map((key, value) => MapEntry(key, value.toString()));
    //compass direction
    String compassDirectionEnJson = await rootBundle
        .loadString("${StringUtils.constantPath}/compass_direction_en.json");
    Map<String, dynamic> tempCompassDirectionEnMap =
        jsonDecode(compassDirectionEnJson);
    compassDirectionEnMap = tempCompassDirectionEnMap
        .map((key, value) => MapEntry(key, value.toString()));

    String compassDirectionViJson = await rootBundle
        .loadString("${StringUtils.constantPath}/compass_direction_vi.json");
    Map<String, dynamic> tempCompassDirectionViMap =
        jsonDecode(compassDirectionViJson);
    compassDirectionViMap = tempCompassDirectionViMap
        .map((key, value) => MapEntry(key, value.toString()));
  }
}
