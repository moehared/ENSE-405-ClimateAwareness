
import 'dart:io';

import 'package:app/main.dart';
import 'package:app/model/personalize_tips.dart';
import 'package:app/personalize_data/data.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/questionaire_screen/food_screen.dart';
import 'package:app/screens/questionaire_screen/goods_services_screen.dart';
import 'package:app/screens/questionaire_screen/transportation.dart';
import 'package:app/screens/questionaire_screen/utilities_screen.dart';
import 'package:app/screens/tabs.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:app/widget/animated_widget.dart';
import 'package:flutter/material.dart';

var foodSelection = FoodConsumption(
  id: '11000',
  tip: TipData.FOODS_TIP,
  type: 'food consumption',
  subTitle: 'food consumption',
  image: 'images/food.png',
);

var _waterUsage = HighWaterUsage(
  id: '1002',
  type: 'high water',
  tip: TipData.WATER_TIP,
  subTitle: 'Use water efficiently',
  image: 'images/high_water.jpg',
);

class QuestinairesScreen extends StatefulWidget {
  static const String routeName = '/QuestinairesScreen';
  static const String RESULT = 'CARBON_RESULT';
  @override
  _QuestinairesScreenState createState() => _QuestinairesScreenState();
}

class _QuestinairesScreenState extends State<QuestinairesScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> tipData = {};
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
                    ? _doneQuestions
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

  void _doneQuestions() async {
     _saveUserChoice();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => HomePage()),
      ModalRoute.withName(HomePage.routeName),
    );
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

void _saveUserChoice() async {
  var heating = await getLocalData(UtilitiesScreen.HEATING_VALUE) ?? 0;
  var electricity =
      await getLocalData(UtilitiesScreen.ELECTRICITY_VALUE) ?? 0;
  var flight = await getLocalData(TransportationScreen.AIRPLANE_VALUE) ?? 0;
  var fuel = await getLocalData(TransportationScreen.FUEL_VALUE) ?? 0;
  var redMeat = await getLocalData(FoodScreen.RED_MEAT_VALUE) ?? 0;
  var whiteMeat = await getLocalData(FoodScreen.WHITE_MEAT_VALUE) ?? 0;
  var others = await getLocalData(FoodScreen.OTHER_SNACKS) ?? 0;
  var goods = await getLocalData(GoodsServicesScreen.GOODS) ?? 0;
  var fewEmails = await getLocalData(GoodsServicesScreen.FEW_DATA) ?? 0;
  var streamRes =
      await getLocalData(GoodsServicesScreen.MORE_STREAMING) ?? 0;
  var option1 = await getLocalData(TransportationScreen.OPTION1) ?? 0;
  var option2 = await getLocalData(TransportationScreen.OPTION2) ?? 0;
  var option3 = await getLocalData(TransportationScreen.OPTION3) ?? 0;
  var option4 = await getLocalData(TransportationScreen.OPTION4) ?? 0;

  var lowWater = await getLocalData(UtilitiesScreen.LOW_WATER_USAGE) ?? 0;
  var highWater = await getLocalData(UtilitiesScreen.HIGH_WATER_USAGE) ?? 0;
  var normalWater =
      await getLocalData(UtilitiesScreen.NORMAL_WATER_USAGE) ?? 0;

  if (redMeat != 0 || whiteMeat != 0 || others != 0) {
    if (!tips.contains(foodSelection.id)) {
      tips.add(foodSelection);
      foodSelection.setUserSelection(true);
    } else {
      foodSelection.setUserSelection(true);
    }
  } else {
    foodSelection.setUserSelection(false);
  }

  if (lowWater > 0 || highWater > 0 || normalWater > 0) {
    _waterSelection();
  } else {
    _waterUsage.setUserSelection(false);
    print('water is set to false');
  }

  var res = (heating +
      electricity +
      flight +
      fuel +
      redMeat +
      option1 +
      option2 +
      option3 +
      option4 +
      whiteMeat +
      others +
      goods +
      lowWater +
      highWater +
      normalWater +
      fewEmails +
      streamRes) /
      1000;

  print(
      'heating = $heating\n electricty =  $electricity\n flight = $flight\n fuel = $fuel\n red_meat = $redMeat\n'
          'white meat = $whiteMeat\n + others = $others\n few email = $fewEmails\n stream res = $streamRes\noption 1 = $option1\n'
          'option2 = $option2\noption 3 = $option3\noption 4 = $option4\nlow water = $lowWater\nHigh water = $highWater\nnormal = $normalWater\n');
  print('res = ${res.toStringAsFixed(2)} ton C02e/month\n');
  saveData(QuestinairesScreen.RESULT, res);
  saveData(PersonalizedTip.TIPS_KEY, tips);
}

void _waterSelection() {
  if (tips.contains(_waterUsage.id)) {
    tips.add(_waterUsage);
    _waterUsage.setUserSelection(true);
    print('water usage is added\n');
  } else {
    _waterUsage.setUserSelection(true);
    print('water usage was already added.\n');
  }
}
