import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../../../../bloc/home/home_state.dart';
import '../../../../utils.dart';

class HumidityWidget extends StatelessWidget {
  HumidityWidget({super.key});

  final List<String> humidityLevels = [
    "Oppressive", //75 - ...
    "Muggy", // 70 - 75
    "Humid", // 65 - 70
    "Tolerable", // 60 - 65
    "Pleasant", // 50 - 60
    "Dry", // 40 - 50
    "Very dry" // ... - 40
  ];

  ///Mức độ 0 - 9% - Siêu Khô Hạn
  ///Mức độ 10 - 19% - Khô Hạn
  ///Mức độ 20 - 29% -  Cực Kỳ Thấp
  ///Mức độ 30 - 39% - Thấp
  ///Mức độ 40 - 49% - Tương đối thấp
  ///Mức độ 50 - 59% - Trung Bình
  ///Mức độ 60 - 69% - Trung bình khá
  ///Mức độ 70 - 79% - Vừa phải
  ///Mức độ 80 - 89% - Tương Đối Cao
  ///Mức độ 90 - 99% - Cao
  ///Mức độ 100% - Bão Hòa (Rất cao)

  String getHumidityLevel(int humidity) {
    if (humidity > 75) {
      return humidityLevels[0];
    } else if (humidity > 70 && humidity <= 75) {
      return humidityLevels[1];
    } else if (humidity > 65 && humidity <= 70) {
      return humidityLevels[2];
    } else if (humidity > 60 && humidity <= 65) {
      return humidityLevels[3];
    } else if (humidity > 50 && humidity <= 60) {
      return humidityLevels[4];
    } else if (humidity > 40 && humidity <= 50) {
      return humidityLevels[5];
    }
    return humidityLevels[6];
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
                              text: state.todayHighLight!.humidity!.toString(),
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: " %", style: TextStyle(fontSize: 14))
                              ])),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  height: 20,
                  child: Row(
                    children: [
                      Image.asset("${StringUtils.imagePath}/humidity.png"),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        getHumidityLevel(state.todayHighLight!.humidity!),
                      )
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
