import 'package:app/main.dart';
import 'package:flutter/material.dart';

class PersonalizedDetailsTips extends StatelessWidget {
  static const String routeName = "/PersonalizedDetailsTips";
  final String id;

  PersonalizedDetailsTips(this.id);

  @override
  Widget build(BuildContext context) {
    final tip =
        tips.firstWhere((element) => element.id == id, orElse: () => null);
    return Scaffold(
      appBar: AppBar(
        title: tip != null ? Text(tip.type) : Text("no type found"),
      ),
      body: Center(
        child: tip != null ? Text(tip.tip) : Text('no tip found'),
      ),
    );
  }
}
