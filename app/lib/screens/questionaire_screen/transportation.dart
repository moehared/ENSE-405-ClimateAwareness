import 'package:app/main.dart';
import 'package:app/model/category.dart';
import 'package:app/model/personalize_tips.dart';
import 'package:app/personalize_data/data.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:app/widget/options_button.dart';
import 'package:app/widget/quesion_card.dart';
import 'package:flutter/material.dart';

var plane = AirPlane(
  id: '10006',
  tip: TipData.PLANE_USAGE_TIP,
  type: 'plane',
  subTitle: 'dont take unnecessary flight',
  image: 'images/plane.jpg',
);
var car = Drive(
  id: '10007',
  tip: TipData.CAR_TIP,
  type: 'car',
  subTitle: 'Cycle or walk short distance',
  image: 'images/less_driving.png',
);
var public = PublicTransportation(
  id: '10008',
  tip: TipData.PUBLIC_USAGE_TIP,
  type: 'public transportation',
  subTitle: 'taking public transportation',
  image: 'images/public.jpg',
);

class TransportationScreen extends StatefulWidget {
  static const String AIRPLANE_VALUE = 'FLIGHT_HOURS';
  static const String FUEL_VALUE = 'FUEL_CONSUMPTION';
  static const String OPTION1 = '30MIN';
  static const String OPTION2 = '1HR';
  static const String OPTION3 = '2HR';
  static const String OPTION4 = 'NONE';
  @override
  _TransportationScreenState createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  final transportation = Transportation();
  double _questionOneValue = 0.0;
  double _questionTwoValue = 0.0;

  var _userChoice1 = false;
  var _userChoice2 = false;
  var _userChoice3 = false;
  var _userChoice4 = false;

  @override
  void initState() {
    removeSavedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text(
              transportation.categoryTitle,
              style: TextStyle(fontFamily: 'Roboto-'),
            ),
          ),
          Container(
            height: media.size.height * 0.70,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                QuestionCard(
                  max: 20,
                  step: 10,
                  question: transportation.questions[0],
                  value: _questionOneValue,
                  onChanged: updateQuestionOneVal,
                  button: Container(),
                ),
                QuestionCard(
                  max: 200,
                  step: 10,
                  question: transportation.questions[1],
                  value: _questionTwoValue,
                  onChanged: updateQuestionTwoVal,
                  button: Container(),
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(transportation.questions[2]),
                    OptionsButton(
                      onTap: _selectedChoice1,
                      choice: '30 min/day',
                      userChoice: _userChoice1,
                    ),
                    OptionsButton(
                      onTap: _selectedChoice2,
                      choice: '1 hr/day',
                      userChoice: _userChoice2,
                    ),
                    OptionsButton(
                      onTap: _selectedChoice3,
                      choice: '2 hr/day',
                      userChoice: _userChoice3,
                    ),
                    OptionsButton(
                      onTap: () => _selectedChoice4(context),
                      choice: 'None i drive',
                      userChoice: _userChoice4,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateQuestionOneVal(value) {
    var res = 0.0;
    setState(() {
      _questionOneValue = value;
      print('selected value1 $_questionOneValue\n');
      res = Transportation.AVERAGE_PLANE_EMISSION * _questionOneValue * 1.1;
      print('res value1 $res\n');
      // transportation.setAirplaneValue(res);
      saveData(TransportationScreen.AIRPLANE_VALUE, res);
    });
    if (_questionOneValue != 0.0) {
      if (!tips.contains(plane.id)) {
        tips.add(plane);
        plane.setUserSelection(true);
      } else {
        plane.setUserSelection(true);
      }
    } else {
      plane.setUserSelection(false);
    }
  }

  void updateQuestionTwoVal(value) {
    var res = 0.0;
    setState(() {
      _questionTwoValue = value;
      print('selected value2 $_questionTwoValue\n');
      res = Transportation.FUEL_EMISSION_FACTOR * _questionTwoValue;
      print('res value 2  $res\n');
      saveData(TransportationScreen.FUEL_VALUE, res);
    });
    if (_questionTwoValue != 0.0) {
      if (!tips.contains(car.id)) {
        tips.add(car);
        car.setUserSelection(true);
      } else {
        car.setUserSelection(true);
      }
    } else {
      car.setUserSelection(false);
    }
  }

  void _selectedChoice1() async {
    setState(() {
      _userChoice1 = !_userChoice1;
      _userChoice2 = false;
      _userChoice3 = false;
      _userChoice4 = false;
    });

    if (_userChoice1) {
      // transportation.setPublicTransportation();
      var res = Transportation.BUS_EMISSION_FACTOR * 25;
      print('res option 1 $res\n');
      saveData(TransportationScreen.OPTION1, res);

      if (!tips.contains(public.id)) {
        tips.add(public);
        public.setUserSelection(true);
      } else {
        public.setUserSelection(true);
      }
    }
    if (_userChoice2 == false ||
        _userChoice3 == false ||
        _userChoice4 == false) {
      await removeLocalData(TransportationScreen.OPTION2);
      await removeLocalData(TransportationScreen.OPTION3);
      await removeLocalData(TransportationScreen.OPTION4);
    }
  }

  void _selectedChoice2() async {
    setState(() {
      _userChoice2 = !_userChoice2;
      _userChoice1 = false;
      _userChoice3 = false;
      _userChoice4 = false;
    });
    if (_userChoice2) {
      // transportation.setPublicTransportation();
      var res = Transportation.BUS_EMISSION_FACTOR * 50;
      print('res for option2 $res\n');
      saveData(TransportationScreen.OPTION2, res);
      if (!tips.contains(public.id)) {
        tips.add(public);
        public.setUserSelection(true);
      } else {
        public.setUserSelection(true);
      }
    }
    if (_userChoice1 == false ||
        _userChoice3 == false ||
        _userChoice4 == false) {
      await removeLocalData(TransportationScreen.OPTION1);
      await removeLocalData(TransportationScreen.OPTION3);
      await removeLocalData(TransportationScreen.OPTION4);
    }
  }

  void _selectedChoice3() async {
    setState(() {
      _userChoice3 = !_userChoice3;
      _userChoice1 = false;
      _userChoice2 = false;
      _userChoice4 = false;
    });
    if (_userChoice3) {
      // transportation.setPublicTransportation();
      var res = Transportation.BUS_EMISSION_FACTOR * 100;
      saveData(TransportationScreen.OPTION3, res);
      if (!tips.contains(public.id)) {
        tips.add(public);
        public.setUserSelection(true);
      } else {
        public.setUserSelection(true);
      }
    }
    if (_userChoice1 == false ||
        _userChoice2 == false ||
        _userChoice4 == false) {
      await removeLocalData(TransportationScreen.OPTION1);
      await removeLocalData(TransportationScreen.OPTION2);
      await removeLocalData(TransportationScreen.OPTION4);
    }
  }

  void _selectedChoice4(context) async {
    setState(() {
      _userChoice4 = !_userChoice4;
      _userChoice1 = false;
      _userChoice2 = false;
      _userChoice3 = false;
    });
    if (_userChoice4) {
      var res = Transportation.AVERAGE_KM_PER_MONTH *
          Transportation.CAR_EMISSION_FACTOR;
      saveData(TransportationScreen.OPTION4, res);

      if (!tips.contains(car.id)) {
        tips.add(car);
        car.setUserSelection(true);
      } else {
        car.setUserSelection(true);
      }
    }
    if (_userChoice1 == false ||
        _userChoice2 == false ||
        _userChoice3 == false) {
      await removeLocalData(TransportationScreen.OPTION1);
      await removeLocalData(TransportationScreen.OPTION2);
      await removeLocalData(TransportationScreen.OPTION3);
    }
  }

  void removeSavedData() {
    removeLocalData(TransportationScreen.FUEL_VALUE);
    removeLocalData(TransportationScreen.AIRPLANE_VALUE);
    removeLocalData(TransportationScreen.OPTION1);
    removeLocalData(TransportationScreen.OPTION2);
    removeLocalData(TransportationScreen.OPTION3);
    removeLocalData(TransportationScreen.OPTION4);
    public.setUserSelection(false);
    car.setUserSelection(false);
    plane.setUserSelection(false);
  }
}
