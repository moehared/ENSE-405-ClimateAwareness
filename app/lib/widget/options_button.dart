import 'package:flutter/material.dart';

class OptionsButton extends StatelessWidget {
  final Function onTap;
  final String choice;
  final bool userChoice;
  OptionsButton({@required this.onTap, @required this.choice, this.userChoice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        // splashColor: Theme.of(context).accentColor.withAlpha(32),
        // borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(
                color: userChoice ? Colors.green : Colors.grey.shade300,
                width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              userChoice
                  ? Icon(
                      Icons.check_circle,
                      size: 26,
                      color: Colors.green,
                    )
                  : Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 3),
                      ),
                    ),
              SizedBox(width: 20),
              Text(choice)
            ],
          ),
        ),
      ),
    );
  }
}
