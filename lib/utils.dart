class StringUtils {
  static String get dayImagePath => "assets/images/weather/day";
  static String get weatherImagePath => "assets/images/weather";
  static String get imagePath => "assets/images";

  //originAPI format "//cdn.weatherapi.com/weather/64x64/day/176.png"
  static String getWeatherIconPath(String originAPI) {
    int indexIcon = originAPI.indexOf(RegExp(r'(\/\w+\/\d+\.png)$'));
    String icon = originAPI.substring(indexIcon);
    String iconPath = "$weatherImagePath$icon";
    return iconPath;
  }
}
