import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/home/home_state.dart';
import '../../../models/view_models/weather_heading_view_model.dart';

class WeatherHeadingWidget extends StatelessWidget {
  const WeatherHeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = BlocProvider.of(context, listen: true);
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is! HomeLoadingState && state.weatherHeading != null) {
          WeatherHeadingViewModel weatherHeading = state.weatherHeading!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(weatherHeading.icon!),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today",
                        textScaleFactor: 2.5,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Text("Sat, 3 Aug"),
                      Text(weatherHeading.localTime!),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weatherHeading.tempC.toString(),
                    textScaleFactor: 3,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "°",
                      textScaleFactor: 3,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "C",
                      textScaleFactor: 3,
                    ),
                  )
                ],
              ),
              Text(
                weatherHeading.weatherConditionText!,
                textScaleFactor: 1.6,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
