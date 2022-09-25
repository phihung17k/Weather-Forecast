import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../../../../bloc/home/home_state.dart';
import '../../../../utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AirQualityWidget extends StatelessWidget {
  final AppLocalizations appLocalizations;
  AirQualityWidget(this.appLocalizations, {super.key});

  //compute by Air Quality Index (AQI)
  final List<String> aqiLevels = [
    "Good", // > 10 miles (0 - 50)
    "Moderate", // 6 - 10 miles (51 - 100)
    "Unhealthy", // 3 - 5 miles (101 - 150)
    "Unhealthy", // 1.5 - 2.75 miles (151 - 200)
    "Very Unhealthy", // 1 - 1.25 miles (201 - 300)
    "Hazardous", // < 1 mile (301 - 500)
    //or order level 1, 2, 3, 4, 5, 6
  ];

  String getAQILevel(int aqi) {
    switch (aqi) {
      case 1:
        return appLocalizations.good;
      case 2:
        return appLocalizations.moderate;
      case 3:
        return appLocalizations.unhealthy;
      case 4:
        return appLocalizations.unhealthy;
      case 5:
        return appLocalizations.very_unhealthy;
      default:
        return appLocalizations.hazardous;
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = BlocProvider.of(context, listen: true);
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is! HomeLoadingState && state.todayHighLight != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${appLocalizations.level} ${state.todayHighLight!.airQualityIndex!}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 15),
                        height: 20,
                        child: Image.asset(
                            "${StringUtils.imagePath}/air_quality.png")),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                          getAQILevel(state.todayHighLight!.airQualityIndex!)),
                    )
                  ],
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
