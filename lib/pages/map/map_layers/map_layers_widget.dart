import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/global/app_themes.dart';
import 'package:weather_forecast/global/bloc/theme_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapLayersWidget extends StatelessWidget {
  final Function()? onPress;
  final AppLocalizations appLocalizations;

  const MapLayersWidget(
    this.appLocalizations, {
    Key? key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeBloc _themeBloc = BlocProvider.of<ThemeBloc>(context, listen: true);
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 60,
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: _themeBloc.state.themeData == appThemeData[AppTheme.dark]
                ? Colors.grey
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Colors.grey,
                offset: Offset(5, 5),
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(
              child: Icon(
                Icons.layers_outlined,
                size: 30,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(appLocalizations.layer)
          ],
        ),
      ),
    );
  }
}
