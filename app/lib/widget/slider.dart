import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final double value;
  final Function onChanged;

  final double max;
  final int step;

  SliderWidget({this.value, this.onChanged, this.max = 200.0, this.step = 5});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.red[700],
        inactiveTrackColor: Colors.red[100],
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        thumbColor: Theme.of(context).accentColor,
        overlayColor: Theme.of(context).accentColor.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.red[700],
        inactiveTickMarkColor: Colors.red[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Theme.of(context).accentColor,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
          value: value,
          min: 0,
          max: max,
          divisions: step,
          label: value == 200.00 && max != 500
              ? '\$${value.toInt()}+'
              : max == 20
                  ? '${value.toInt()}\hr'
                  : max == 16
                      ? '${value.toInt()}'
                      : step == 10
                          ? '\$${value.toInt()}'
                          : value == 5000.00
                              ? '\$${value.toInt()}+'
                              : '\$${value.toInt()}',
          onChanged: onChanged),
    );
  }
}

//
// setState(
// () {
// _value = value;
// },
// );
