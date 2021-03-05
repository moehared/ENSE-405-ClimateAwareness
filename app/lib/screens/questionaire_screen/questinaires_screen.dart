import 'dart:io';

import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/questionaire_screen/food_screen.dart';
import 'package:app/screens/questionaire_screen/goods_services_screen.dart';
import 'package:app/screens/questionaire_screen/transportation.dart';
import 'package:app/screens/questionaire_screen/utilities_screen.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:app/widget/animated_widget.dart';
import 'package:flutter/material.dart';

class QuestinairesScreen extends StatefulWidget {
  static const String routeName = '/QuestinairesScreen';
  @override
  _QuestinairesScreenState createState() => _QuestinairesScreenState();
}

class _QuestinairesScreenState extends State<QuestinairesScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();

  int _selectedPage = 0;

  final List<Widget> pages = [
    UtilitiesScreen(),
    TransportationScreen(),
    FoodScreen(),
    GoodsServicesScreen(),
  ];

  AnimationController _progressController;

  Animation<double> _progressAnimation;

  double growStepWidth, beginWidth, endWidth = 0.0;
  int totalPages = 4;

  @override
  void initState() {
    _progressController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _progressAnimation =
        Tween<double>(begin: 0, end: 0).animate(_progressController);
    _setProgressAnim(0, 1);
    super.initState();
  }

  @override
  void dispose() {
    _progressController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    var maxWidth = media.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaires'),
        leading: _selectedPage == 0
            ? null
            : IconButton(
                icon: (Icon(Icons.arrow_back)),
                onPressed: previousQuestionScreen,
              ),
      ),
      body: Stack(
        children: [
          PageView.builder(
            itemCount: pages.length,
            itemBuilder: (ctx, index) {
              return pages[index];
            },
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              _progressController.reset();
              _setProgressAnim(maxWidth, index + 1);
            },
            scrollDirection: Axis.horizontal,
            controller: _pageController,
          ),
          // Positioned(
          //   child: LinearProgressIndicator(
          //     value: _progressAnimation.value,
          //     valueColor:
          //         AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
          //     minHeight: 20,
          //     backgroundColor: Colors.grey.shade300,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AnimatedProgressBar(
                    animation: _progressAnimation,
                  ),
                  Expanded(
                    child: Container(
                      height: 10.0,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: _selectedPage == pages.length - 1 && Platform.isIOS
                ? 200
                : Platform.isIOS
                    ? 50
                    : 15,
            right: 10,
            left:
                _selectedPage == pages.length - 1 && Platform.isIOS ? 10 : null,
            child: Container(
              width: _selectedPage == pages.length - 1 ? double.infinity : 100,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextButton(
                child: Text(
                  _selectedPage == pages.length - 1 ? 'Continue' : 'Next',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _selectedPage == pages.length - 1
                    ? _userProfile
                    : nextQuestionScreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void previousQuestionScreen() {
    if (_selectedPage > 0) {
      _selectedPage--;
      _pageController.animateToPage(_selectedPage,
          duration: Duration(microseconds: 250), curve: Curves.bounceInOut);
    }
  }

  void nextQuestionScreen() {
    if (_selectedPage < pages.length - 1) {
      _selectedPage++;
      _pageController.animateToPage(_selectedPage,
          duration: Duration(microseconds: 250), curve: Curves.bounceInOut);
      print('Selected page index $_selectedPage\n');
    }
  }

  void _userProfile() async {
    // var utilities = Utilities();
    // var transportation = Transportation();
    // var food = Food()..c02e;
    // var goodsAndService = GoodsServices();
    // double result = (utilities.c02e +
    //         transportation.c02e +
    //         food.c02e +
    //         goodsAndService.c02e) /
    //     1000;
    // print('Results is = $result\n');
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (BuildContext context) => HomePage()),
    //   ModalRoute.withName(HomePage.routeName),
    // );

    var heating = await getLocalData(UtilitiesScreen.HEATING_VALUE) ?? 0;
    var electricity =
        await getLocalData(UtilitiesScreen.ELECTRICITY_VALUE) ?? 0;
    var flight = await getLocalData(TransportationScreen.AIRPLANE_VALUE) ?? 0;
    var fuel = await getLocalData(TransportationScreen.FUEL_VALUE) ?? 0;
    var red_meat = await getLocalData(FoodScreen.RED_MEAT_VALUE) ?? 0;
    var white_meat = await getLocalData(FoodScreen.WHITE_MEAT_VALUE) ?? 0;
    var others = await getLocalData(FoodScreen.OTHER_SNACKS) ?? 0;
    var goods = await getLocalData(GoodsServicesScreen.GOODS) ?? 0;
    var few_emails = await getLocalData(GoodsServicesScreen.FEW_DATA) ?? 0;
    var stream_res =
        await getLocalData(GoodsServicesScreen.MORE_STREAMING) ?? 0;
    var option1 = await getLocalData(TransportationScreen.OPTION1) ?? 0;
    var option2 = await getLocalData(TransportationScreen.OPTION2) ?? 0;
    var option3 = await getLocalData(TransportationScreen.OPTION3) ?? 0;
    var option4 = await getLocalData(TransportationScreen.OPTION4) ?? 0;

    double res = (heating +
            electricity +
            flight +
            fuel +
            red_meat +
            option1 +
            option2 +
            option3 +
            option4 +
            white_meat +
            others +
            goods +
            few_emails +
            stream_res) /
        1000;

    print(
        'heating = $heating\n electricty =  $electricity\n flight = $flight\n fuel = $fuel\n red_meat = $red_meat\n'
        'white meat = $white_meat\n + others = $others\n few email = $few_emails\n stream res = $stream_res\noption 1 = $option1\n'
        'option2 = $option2\noption 3 = $option3\noption 4 = $option4\n');
    print('res = ${res.toStringAsFixed(2)} kgC02e/month\n');
  }

  void continueBtn(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => ProfileScreen()), (route) => false);
  }

  void _setProgressAnim(double maxWidth, int curPageIndex) {
    setState(() {
      if (curPageIndex == 1) {
        growStepWidth = (maxWidth / pages.length);
        beginWidth = growStepWidth * (curPageIndex - 1);
        endWidth = growStepWidth * curPageIndex;

        _progressAnimation = Tween<double>(begin: beginWidth, end: endWidth)
            .animate(_progressController);
      } else {
        growStepWidth = (maxWidth / pages.length);
        beginWidth = growStepWidth * (curPageIndex - 1) - 17;
        endWidth = growStepWidth * curPageIndex - 17;

        _progressAnimation = Tween<double>(begin: beginWidth, end: endWidth)
            .animate(_progressController);
      }
    });

    _progressController.forward();
  }
}
