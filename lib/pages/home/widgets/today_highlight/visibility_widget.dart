import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../../../../bloc/home/home_state.dart';
import '../../../../utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VisibilityWidget extends StatelessWidget {
  final AppLocalizations appLocalizations;
  VisibilityWidget(this.appLocalizations, {super.key});

  //compute by Air Quality Index (AQI)
  final List<String> visibilityLevels = [
    "Good", // > 10 miles (0 - 50)
    "Moderate", // 6 - 10 miles (51 - 100)
    "Unhealthy", // 3 - 5 miles (101 - 150)
    "Unhealthy", // 1.5 - 2.75 miles (151 - 200)
    "Very Unhealthy", // 1 - 1.25 miles (201 - 300)
    "Hazardous", // < 1 mile (301 - 500)
  ];

  //unit km
  String getVisibilityLevel(double visibility) {
    if (visibility > 16) {
      return appLocalizations.good;
    } else if (visibility > 9.65 && visibility <= 16) {
      return appLocalizations.moderate;
    } else if (visibility > 4.8 && visibility <= 9.65) {
      return appLocalizations.unhealthy;
    } else if (visibility > 2.4 && visibility <= 4.8) {
      return appLocalizations.unhealthy;
    } else if (visibility > 1.6 && visibility <= 2.4) {
      return appLocalizations.very_unhealthy;
    }
    return appLocalizations.hazardous;
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
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: state.todayHighLight!.visibilityKm!
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: " km", style: TextStyle(fontSize: 14))
                              ])),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  height: 20,
                  child: Row(
                    children: [
                      Image.asset("${StringUtils.imagePath}/visibility.png"),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(getVisibilityLevel(
                          state.todayHighLight!.visibilityKm!))
                    ],
                  ),
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
