import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../../enums.dart';
import '../../log.dart';
import '../../routes.dart';
import '../../utils.dart';
import 'widgets/hourly_forecast/hourly_forecast_widget.dart';
import 'widgets/today_highlight/today_highlight_widget.dart';
import 'widgets/weather_heading_widget.dart';

class HomePage extends StatefulWidget {
  final HomeBloc bloc;
  const HomePage(this.bloc, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc get _bloc => widget.bloc;

  List<TodayItemEnum> todayItems = [
    TodayItemEnum.uvIndex,
    TodayItemEnum.windStatus,
    TodayItemEnum.sunStatus,
    TodayItemEnum.humidity,
    TodayItemEnum.visibility,
    TodayItemEnum.airQuality
  ];

  @override
  void initState() {
    super.initState();
    _bloc.add(InitialDataEvent());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      Marker? marker = settings.arguments as Marker?;
      if (marker != null) {
        Log.d(
            "Select marker (lat, lon): ${marker.position.latitude}, ${marker.position.longitude}");
        _bloc.add(WeatherForecastUpdationEvent(marker));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/weather/cloudy.jpg",
              ),
              fit: BoxFit.cover),
        ),
        // color: Colors.amber,
        constraints: const BoxConstraints.expand(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: BlocBuilder<HomeBloc, HomeState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is! HomeLoadingState && state.locationName != null) {
                  return Text(state.locationName!,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 23));
                }
                return const CircularProgressIndicator();
              },
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () async {
                    final marker =
                        await Navigator.pushNamed(context, Routes.map)
                            as Marker?;
                    if (marker != null) {
                      Log.d(
                          "Select marker (lat, lon): ${marker.position.latitude}, ${marker.position.longitude}");
                      _bloc.add(WeatherForecastUpdationEvent(marker));
                    }
                  },
                  icon: const Icon(
                    Icons.map,
                    size: 26,
                  ))
            ],
          ),
          body: Container(
            color: Colors.transparent,
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  WeatherHeadingWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  TodayHighlightWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  HourlyForecastWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}