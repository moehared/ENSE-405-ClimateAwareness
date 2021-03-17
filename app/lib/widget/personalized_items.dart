import 'package:app/screens/personalized_details.dart';
import 'package:flutter/material.dart';

class PersonalizedItems extends StatelessWidget {
  final String title;
  final String id;
  final String image;

  PersonalizedItems({this.title, this.id, this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: GridTile(
          child: GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(PersonalizedDetailsTips.routeName, arguments: id),
            child: Hero(
              tag: id,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87.withOpacity(0.5),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
