import 'package:flutter/material.dart';

import 'reusable_card.dart';

class CategoriesCards extends StatelessWidget {
  const CategoriesCards();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        height: deviceSize.height * 0.20,
        width: deviceSize.width,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              ReusableCard(
                // colour: Colors.orange.shade400,
                subTitle: "coming soon",
              ),
              ReusableCard(
                // colour: Colors.blue.shade400,
                subTitle: "coming soon",
              ),
              ReusableCard(
                subTitle: "coming soon",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
