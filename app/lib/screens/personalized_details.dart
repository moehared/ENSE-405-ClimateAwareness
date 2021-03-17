import 'package:app/model/personalize_tips.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalizedDetailsTips extends StatefulWidget {
  static const String routeName = "/PersonalizedDetailsTips";
  final String id;

  PersonalizedDetailsTips(this.id);

  @override
  _PersonalizedDetailsTipsState createState() =>
      _PersonalizedDetailsTipsState();
}

class _PersonalizedDetailsTipsState extends State<PersonalizedDetailsTips> {
  List<Widget> itemsData = [];
  var tipData = [];
  var tip;

  @override
  void initState() {
    _getTips();
    super.initState();
  }

  _getTips() async {
    final res = await getLocalData(PersonalizedTip.TIPS_KEY) ?? null;
    if (res != null) {
      // res.forEach((element) {
      //   print('Retrieve data from json decode is ${element['type']}\n');
      // });
      setState(() {
        tipData = res;
        // print('TIP data is $tipData\n');
        // tipData.forEach((element) {
        //   print('Retrieve data from json decode is ${element['type']}\n');
        // });
      });

      tip = tipData.firstWhere((element) => element['id'] == widget.id,
          orElse: () => null);

      print('tip type is ${tip['type']}\n');
    } else {
      print('Result retrieve is null\n');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${tip['type']}'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.id,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.30,
                child: tip != null
                    ? Image.asset(
                        tip['image'],
                        // width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Text('data is null'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Understand what is at stake',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            tip != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tip['tip']),
                  )
                : Text('no tip found'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: 'Click here to Learn more',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (tip['learn'] != null) {
                        if (await canLaunch(tip['learn'])) {
                          print('launching...\n');
                          await launch(tip['learn']);
                        } else {
                          throw 'Could not launch ${tip['learn']}\n';
                        }
                      } else {
                        print('link is ${tip['learn']}');
                      }
                    },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
