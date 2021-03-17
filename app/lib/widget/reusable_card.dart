import 'package:app/screens/personalized_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  // final String titleText;
  final String id;
  final String imageAsset;
  final String subTitle;

  ReusableCard({
    this.colour = Colors.white,
    this.imageAsset,
    @required this.id,
    @required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PersonalizedDetailsTips.routeName, arguments: id);
      },
      child: Container(
        width: deviceSize.width * 0.40,
        margin: EdgeInsets.only(left: 10.0),
        height: deviceSize.height * 0.25 - 50,
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
              Flexible(
                flex: 2,
                child: Hero(
                    tag: id,
                    child: Image.asset(imageAsset ?? 'images/image.png')),
              ),
              SizedBox(height: 4),
              Flexible(
                child: Container(
                  width: deviceSize.width * 0.40,
                  child: Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
