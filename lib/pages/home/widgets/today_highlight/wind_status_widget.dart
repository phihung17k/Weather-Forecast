import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../../../../bloc/home/home_state.dart';
import '../../../../utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WindStatusWidget extends StatelessWidget {
  final AppLocalizations appLocalizations;
  const WindStatusWidget(this.appLocalizations, {super.key});

  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = BlocProvider.of(context, listen: true);
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is! HomeLoadingState && state.todayHighLight != null) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: state.todayHighLight!.windKph!.toString(),
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: const <TextSpan>[
                            TextSpan(
                                text: " km/h", style: TextStyle(fontSize: 14))
                          ])),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 20,
                    child: Image.asset("${StringUtils.imagePath}/compass.png")),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    appLocalizations.localeName == "vi"
                        ? compassDirectionViMap[
                            state.todayHighLight!.windDirection!.toLowerCase()]!
                        : compassDirectionEnMap[state
                            .todayHighLight!.windDirection!
                            .toLowerCase()]!,
                  ),
                )
              ],
            ),
          ]);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
