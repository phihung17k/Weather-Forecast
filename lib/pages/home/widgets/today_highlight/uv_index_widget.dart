import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../../../../bloc/home/home_state.dart';
import '../../painters/uv_index_painter.dart';
import '../../painters/uv_progress_painter.dart';

class UVIndexWidget extends StatelessWidget {
  final double widthCard;

  const UVIndexWidget(this.widthCard, {super.key});

  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = BlocProvider.of(context, listen: true);
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is! HomeLoadingState && state.todayHighLight != null) {
          return Stack(alignment: Alignment.center, children: [
            CustomPaint(
              size: const Size(200, 80),
              painter: UVProgressPainter(),
              foregroundPainter: UVIndexPainter(state.todayHighLight!.uvIndex!),
            ),
            Positioned(
                bottom: 5,
                child: Text(
                  state.todayHighLight!.uvIndex!.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
            //1 arc = 1 pi,
            //divide into 5 sections: 0, pi/5, 2pi/5, 3pi/5, 4pi/5, pi
            Positioned(
                left: 0.8 * (widthCard - 7) / 6,
                top: 30,
                child: const Text(
                  "3", //width text = 7
                  textScaleFactor: 0.8,
                )),

            Positioned(
                // left: 20 + 53 - 53 * cos(2 * pi / 5),
                left: 2 * (widthCard - 7) / 6,
                top: 10,
                child: const Text(
                  "6",
                  textScaleFactor: 0.8,
                )),
            Positioned(
                left: 4 * (widthCard - 7) / 6,
                top: 10,
                child: const Text(
                  "9",
                  textScaleFactor: 0.8,
                )),
            Positioned(
                left: 5.2 * (widthCard - 7) / 6,
                top: 30,
                child: const Text(
                  "12", //width text = 13
                  textScaleFactor: 0.8,
                )),
          ]);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
