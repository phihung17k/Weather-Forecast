import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_forecast/bloc/home/home_event.dart';
import 'package:weather_forecast/bloc/home/home_state.dart';
import 'package:weather_forecast/models/current/current_model.dart';
import 'package:weather_forecast/models/forecast/forecast_day/hour_model.dart';
import 'package:weather_forecast/models/forecast/forecast_model.dart';
import 'package:weather_forecast/models/location/location_model.dart';
import 'package:weather_forecast/models/view_models/hourly_forecast_item_view_model.dart';
import 'package:weather_forecast/models/view_models/weather_heading_view_model.dart';
import 'package:weather_forecast/services/interface/i_home_service.dart';

import '../../log.dart';
import '../../models/view_models/today_highlight_view_model.dart';
import '../../utils.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeService _service;

  HomeBloc(this._service) : super(const HomeState()) {
    // on((event, emit) {});
    on<InitialDataEvent>(initData);
    // on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
    on<WeatherForecastUpdationEvent>(updateWeatherForecastByNewLocation);
  }

  Future<void> initData(HomeEvent event, Emitter<HomeState> emitter) async {
    //check permission
    Position? position = await checkPermission();
    // position ??= await Geolocator.getLastKnownPosition();
    //get default position - Hanoi lat: 21.0313511, lon: 105.8309554
    String location = "Hanoi";
    if (position != null) {
      //format: "lat lon"
      location = "${position.latitude} ${position.longitude}";
    }

    //init data
    await getData(emitter, location);
  }

  Future<void> getData(Emitter<HomeState> emitter, String location) async {
    emitter.call(HomeLoadingState());
    var weatherForecastToday = await _service.getWeatherForecastToday(location);
    if (weatherForecastToday != null) {
      LocationModel locationModel = weatherForecastToday.location!;
      CurrentModel currentModel = weatherForecastToday.current!;
      ForecastModel forecastModel = weatherForecastToday.forecast!;

      //weather heading
      var weatherHeading = WeatherHeadingViewModel(
          icon: StringUtils.getWeatherIconPath(currentModel.condition!.icon!),
          localTime: locationModel.localtime!,
          tempC: currentModel.tempC!,
          tempF: currentModel.tempF!,
          weatherConditionText: currentModel.condition!.text!);

      //today highlight
      var todayHighlight = TodayHighlightViewModel(
          uvIndex: currentModel.uv!,
          windKph: currentModel.windKph!,
          windDirection: currentModel.windDirection!,
          sunrise: forecastModel.forecastDays![0].astro!.sunrise!,
          sunset: forecastModel.forecastDays![0].astro!.sunset!,
          humidity: currentModel.humidity!,
          visibilityKm: currentModel.visKm!,
          airQualityIndex: currentModel.airQualityModel!.index!);

      //hourly
      List<HourModel> hourModels = forecastModel.forecastDays![0].hours!;
      List<HourlyForecastItemViewModel> hourlyForecasts =
          hourModels.map<HourlyForecastItemViewModel>((hourModel) {
        String hourlyIcon =
            StringUtils.getWeatherIconPath(hourModel.condition!.icon!);
        //hourModel.time = 2022-09-20 00:00
        return HourlyForecastItemViewModel(
            time: hourModel.time!.split(" ")[1],
            icon: hourlyIcon,
            tempC: hourModel.tempC!,
            tempF: hourModel.tempF!);
      }).toList();

      emitter.call(state.copyWith(
          locationName: locationModel.name ?? "Undefined",
          weatherHeading: weatherHeading,
          todayHighLight: todayHighlight,
          hourlyForecasts: hourlyForecasts));
    }
  }

  Future<Position?> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Log.i("Accept location permission");
      return await Geolocator.getCurrentPosition();
    } else if (permission == LocationPermission.deniedForever) {
      Log.i("User opens App Settings for modify permission");
      await Geolocator.openAppSettings();
      // await Geolocator.openLocationSettings();
    }
    Log.i("Location permission is refused");
    return null;
  }

  Future<void> updateWeatherForecastByNewLocation(
      WeatherForecastUpdationEvent event, Emitter<HomeState> emitter) async {
    emitter.call(HomeLoadingState());
    String location = event.marker!.markerId.value;
    await getData(emitter, location);
  }
}
