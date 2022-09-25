import 'package:flutter/material.dart';
import '../../../../enums.dart';
import 'today_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodayHighlightWidget extends StatelessWidget {
  const TodayHighlightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Theme(
      data: ThemeData(
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.black))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: double.maxFinite,
            child: Text(
              appLocalizations.today_highlight,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: TodayItemWidget(TodayItemEnum.uvIndex)),
              Expanded(child: TodayItemWidget(TodayItemEnum.windStatus)),
              Expanded(child: TodayItemWidget(TodayItemEnum.sunStatus)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: TodayItemWidget(TodayItemEnum.humidity)),
              Expanded(child: TodayItemWidget(TodayItemEnum.visibility)),
              Expanded(child: TodayItemWidget(TodayItemEnum.airQuality)),
            ],
          ),
        ],
      ),
    );
  }
}
