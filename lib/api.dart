class Api {
  static String get _baseURL => "http://api.weatherapi.com/v1";

  static String get currentWeather => "/current.json";
  static String get forecast => "/forecast.json";
  static String get search => "/forecast.json"; //search and automcomplete
  static String get history => "/history.json";
  static String get future => "/future.json";

  static String getForecastURL(
      String key, String location, int day, String aqi) {
    return "$_baseURL$forecast?key=$key&q=$location&days=$day&aqi=$aqi";
  }
}
