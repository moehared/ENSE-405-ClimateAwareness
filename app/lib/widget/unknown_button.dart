import 'package:flutter/material.dart';

class UnknowButton extends StatelessWidget {
  final Function onTap;
  const UnknowButton({
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextButton(
          child: Text(
            'I don\'t know',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
