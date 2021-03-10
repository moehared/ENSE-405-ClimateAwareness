import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  // final String titleText;
  final String imageAsset;
  final String subTitle;

  ReusableCard({
    this.colour = Colors.white,
    this.imageAsset,
    @required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width * 0.30,
      margin: EdgeInsets.only(right: 10.0),
      height: deviceSize.height * 0.25 - 60,
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Text(
            //   titleText,
            //   style: TextStyle(
            //       fontSize: 25,
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold),
            // ),
            Expanded(child: Image.asset(imageAsset ?? 'images/image.png')),
            SizedBox(height: 4),
            Text(
              subTitle,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
