import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../../../../bloc/home/home_state.dart';
import '../../../../utils.dart';

class SunStatusWidget extends StatelessWidget {
  const SunStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = BlocProvider.of(context, listen: true);
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is! HomeLoadingState && state.todayHighLight != null) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child:
                            Image.asset("${StringUtils.imagePath}/sunrise.png"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        state.todayHighLight!.sunrise!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child:
                            Image.asset("${StringUtils.imagePath}/sunset.png"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        state.todayHighLight!.sunset!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                ]);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
