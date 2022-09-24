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

  static String get _baseMapURL => "https://mvs.bslmeiyu.com/api/v1/config";
  static String get autocomplete => "/place-api-autocomplete";
  static String get geocode => "/geocode-api";

  static String getSuggestingLocationsURL(String searchedValue) {
    return "$_baseMapURL$autocomplete?search_text=$searchedValue&lang=vi";
  }

  static String getGeocodingLocationURL(double latitude, double longitude) {
    return "$_baseMapURL$geocode?lat=$latitude&lng=$longitude&lang=vi";
  }
}
