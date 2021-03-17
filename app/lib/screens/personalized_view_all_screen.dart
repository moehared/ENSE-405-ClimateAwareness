import 'package:app/model/personalize_tips.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:app/widget/personalized_items.dart';
import 'package:flutter/material.dart';

class PersonalizedViewAllScreen extends StatefulWidget {
  static const String PERSONALIZED_VIEW_ALL = '/PERSONALIZED_VIEW_ALL';

  @override
  _PersonalizedViewAllScreenState createState() =>
      _PersonalizedViewAllScreenState();
}

class _PersonalizedViewAllScreenState extends State<PersonalizedViewAllScreen> {
  var tip;
  var tipData = [];
  // final tipData = tips.where((element) {
  //   if (element.userChoice == false) {
  //     return false;
  //   }
  //   return true;
  // });

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
      });
    } else {
      print('Result retrieve is null\n');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Personalized Tips'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Personalized tips for you',
                style: TextStyle(
                  fontFamily: 'Roboto-Bold',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            tipData.isEmpty
                ? Center(
                    child: Text(
                      'No personalized tips yet. Start answering questionnaires',
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: tipData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (ctx, index) {
                        var data = tipData.elementAt(index);
                        return PersonalizedItems(
                          // id: data.id,
                          // image: data.image,
                          // title: data.subTitle,
                          id: data['id'],
                          image: data['image'],
                          title: data['subtitle'],
                        );
                        // final item = product.items[index];
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
