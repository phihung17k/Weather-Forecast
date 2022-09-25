import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_forecast/global/app_themes.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../../enums.dart';
import '../../global/bloc/theme_bloc.dart';
import '../../global/bloc/theme_event.dart';
import '../../log.dart';
import '../../routes.dart';
import '../../utils.dart';
import 'widgets/hourly_forecast/hourly_forecast_widget.dart';
import 'widgets/today_highlight/today_highlight_widget.dart';
import 'widgets/weather_heading_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  Widget build(BuildContext context) {
    ThemeBloc _themeBloc = BlocProvider.of(context, listen: true);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider.value(
      value: _bloc,
      child: RefreshIndicator(
        onRefresh: () async {
          _bloc.add(RefreshDataEvent());
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/weather/default_night.webp",
                ),
                fit: BoxFit.fill),
          ),
          // color: Colors.amber,
          constraints: const BoxConstraints.expand(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: BlocBuilder<HomeBloc, HomeState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is! HomeLoadingState &&
                      state.locationName != null) {
                    return Text(
                      state.locationName!,
                      style: Theme.of(context).textTheme.headline6,
                      // const TextStyle(
                      //     // color: Colors.black,
                      //     fontSize: 23,
                      //     overflow: TextOverflow.visible,
                      //     )
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                    );
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
                      final marker = await Navigator.pushNamed(
                          context, Routes.map,
                          arguments: _bloc.state.locationCoordinate) as Marker?;
                      if (marker != null) {
                        Log.d(
                            "Select marker (lat, lon): ${marker.position.latitude}, ${marker.position.longitude}");
                        _bloc.add(WeatherForecastUpdationEvent(marker));
                      }
                    },
                    icon: Image.asset(
                      "${StringUtils.imagePath}/map.png",
                      fit: BoxFit.cover,
                    )),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                shrinkWrap: true,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                        // image: DecorationImage(
                        //     image: AssetImage(
                        //         "${StringUtils.imagePath}/weather_forecast_icon_round.png"),
                        //     fit: BoxFit.contain),
                        border: Border(
                            bottom: BorderSide(
                                color: _themeBloc.state.themeData ==
                                        appThemeData[AppTheme.light]
                                    ? Colors.black
                                    : Colors.white))),
                    child: Text(
                      appLocalizations.app_settings,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  ListTile(
                    title: Text(appLocalizations.theme_mode),
                    trailing: Switch(
                      value: _themeBloc.state.themeData ==
                          appThemeData[AppTheme.dark],
                      onChanged: (value) {
                        AppTheme newTheme = AppTheme.light;
                        if (value) newTheme = AppTheme.dark;
                        _themeBloc.add(ChangingThemeEvent(newTheme: newTheme));
                      },
                    ),
                  )
                ],
              ),
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
      ),
    );
  }
}
