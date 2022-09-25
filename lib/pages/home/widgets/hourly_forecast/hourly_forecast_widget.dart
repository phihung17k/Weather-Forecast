import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../../../../bloc/home/home_state.dart';
import 'hourly_forecast_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HourlyForecastWidget extends StatefulWidget {
  const HourlyForecastWidget({super.key});

  @override
  State<HourlyForecastWidget> createState() => _HourlyForecastWidgetState();
}

class _HourlyForecastWidgetState extends State<HourlyForecastWidget> {
  ScrollController? _scrollController;
  int currentHour = 0;
  double widthHourlyItem = 0;
  double heightHourly = 0;
  StreamController<bool>? _streamController;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    currentHour = int.parse(DateFormat('HH').format(now));
    _scrollController = ScrollController();
    _streamController = StreamController();
    _streamController!.stream.listen((event) {
      if (_scrollController!.hasClients) {
        if (currentHour >= 4 && currentHour < 20) {
          // _scrollController!.jumpTo((currentHour - 3) * widthHourlyItem);
          _scrollController!.animateTo((currentHour - 3) * widthHourlyItem,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate);
        } else if (currentHour >= 20) {
          // _scrollController!.jumpTo((currentHour - 5) * widthHourlyItem);
          _scrollController!.animateTo((currentHour - 5) * widthHourlyItem,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate);
        }
      }
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // print("_scrollController!.hasClients ${_scrollController!.hasClients}");
    //   if (_scrollController!.hasClients) {
    //     // print("YES _scrollController!.hasClients");
    //     if (currentHour >= 4 && currentHour < 20) {
    //       _scrollController!.jumpTo((currentHour - 3) * widthHourlyItem);
    //     } else if (currentHour >= 20) {
    //       _scrollController!.jumpTo((currentHour - 5) * widthHourlyItem);
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = BlocProvider.of(context, listen: true);

    widthHourlyItem = MediaQuery.of(context).size.width / 7;
    heightHourly = MediaQuery.of(context).size.height / 6;

    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        height: heightHourly,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalizations.hourly_forecast,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is! HomeLoadingState &&
                    state.hourlyForecasts != null) {
                  _streamController!.add(true);
                  return Expanded(
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[300],
                          ),
                        ),
                        ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: state.hourlyForecasts!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var hourlyForecastItem =
                                state.hourlyForecasts![index];
                            if (index == currentHour) {
                              return HourlyForecastItemWidget(
                                hourlyForecastItem.time!,
                                hourlyForecastItem.tempC!,
                                hourlyForecastItem.tempF!,
                                hourlyForecastItem.icon!,
                                isCurrentHour: true,
                              );
                            }
                            return HourlyForecastItemWidget(
                              state.hourlyForecasts![index].time!,
                              hourlyForecastItem.tempC!,
                              hourlyForecastItem.tempF!,
                              hourlyForecastItem.icon!,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ));
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }
}
