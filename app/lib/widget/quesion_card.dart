import 'dart:io';

import 'package:app/widget/slider.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final double value;
  final Function onChanged;
  final Widget button;
  final double max;
  final Widget exampleActivities;
  final int step;

  QuestionCard({
    @required this.question,
    @required this.value,
    @required this.onChanged,
    @required this.button,
    this.step,
    this.max,
    this.exampleActivities,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        width: double.infinity,
        height: Platform.isIOS
            ? MediaQuery.of(context).size.height * 0.20
            : MediaQuery.of(context).size.height * 0.30,
        decoration: BoxDecoration(
            // color: Colors.purple,
            borderRadius: BorderRadius.circular(32.0),
            border: Border.all(color: Colors.grey.shade300, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                question,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SliderWidget(
              max: max ?? 200,
              step: step ?? 5,
              onChanged: onChanged,
              value: value,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: exampleActivities ?? Container(),
              ),
            ),
            Expanded(child: button),
          ],
        ),
      ),
    );
  }
}
