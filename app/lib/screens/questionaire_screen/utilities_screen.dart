import 'package:app/main.dart';
import 'package:app/model/category.dart';
import 'package:app/model/personalize_tips.dart';
import 'package:app/personalize_data/data.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:app/widget/options_button.dart';
import 'package:app/widget/quesion_card.dart';
import 'package:app/widget/unknown_button.dart';
import 'package:flutter/material.dart';

var low = LowWaterUsage(
  id: '1000',
  type: 'low water',
  tip: TipData.WATER_TIP,
  subTitle: 'you doing good for using low water',
  image: 'images/high_water.jpg',
);
var normal = NormalWaterUsage(
  id: '1001',
  type: 'normal',
  tip: TipData.WATER_TIP,
  subTitle: 'Use water efficiently',
  image: 'images/high_water.jpg',
);
var high = HighWaterUsage(
  id: '1002',
  type: 'high water',
  tip: TipData.WATER_TIP,
  subTitle: 'Use water efficiently',
  image: 'images/high_water.jpg',
);

var energy = EnergyConsumption(
  id: '1003',
  tip: TipData.ENERGY_TIP,
  type: 'energy',
  subTitle: 'Use Energy efficiently',
  image: 'images/energy.jpg',
);

class UtilitiesScreen extends StatefulWidget {
  static const String HEATING_VALUE = 'HEATING';
  static const String ELECTRICITY_VALUE = 'ELECTRICITY';
  static const String LOW = 'LOW';
  static const String NORMAL = 'NORMAL';
  static const String HIGH = 'HIGH';
  static const String LOW_WATER_USAGE = 'LOW_WATER_USAGE';
  static const String NORMAL_WATER_USAGE = 'NORMAL_WATER_USAGE';
  static const String HIGH_WATER_USAGE = 'HIGH_WATER_USAGE';

  @override
  _UtilitiesScreenState createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  final utilities = Utilities();
  double _questionOneValue = 0.0;
  double _questionTwoValue = 0.0;
  var _userChoice1 = false;
  var _userChoice2 = false;
  var _userChoice3 = false;

  @override
  void initState() {
    removedSavedData();
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
              utilities.categoryTitle,
              style: TextStyle(fontFamily: 'Roboto-'),
            ),
          ),
          Container(
            height: media.size.height * 0.70,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                QuestionCard(
                    max: 200,
                    step: 10,
                    question: utilities.questions[0],
                    value: _questionOneValue,
                    onChanged: updateQuestionOneVal,
                    button: UnknowButton(
                      onTap: () {
                        setState(() {
                          _removeData(UtilitiesScreen.HEATING_VALUE);
                          _questionOneValue = 60;
                          var res = Utilities.HEATING_EMISSION_FACTOR *
                              _questionOneValue;
                          saveData(UtilitiesScreen.HEATING_VALUE, res);
                        });
                        _userEnergyChoice();
                      },
                    )),
                QuestionCard(
                  question: utilities.questions[1],
                  value: _questionTwoValue,
                  onChanged: updateQuestionTwoVal,
                  button: UnknowButton(
                    onTap: () {
                      setState(() {
                        _removeData(UtilitiesScreen.ELECTRICITY_VALUE);
                        _questionTwoValue = 80;
                        var res = Utilities.ELECTRICITY_EMISSION_FACTOR *
                            _questionTwoValue;
                        saveData(UtilitiesScreen.ELECTRICITY_VALUE, res);
                      });
                      _userEnergyChoice();
                    },
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(utilities.questions[2]),
                    OptionsButton(
                      onTap: () => _selectedChoice1(context),
                      choice: 'Low e.g. less shower, less water usage',
                      userChoice: _userChoice1,
                    ),
                    OptionsButton(
                      onTap: _selectedChoice2,
                      choice: 'Normal',
                      userChoice: _userChoice2,
                    ),
                    OptionsButton(
                      onTap: () => _selectedChoice3(context),
                      userChoice: _userChoice3,
                      choice:
                          'High e.g. long shower, car wash at home,\nkeeping tab water running  when not in use',
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

  void _selectedChoice1(context) {
    setState(() {
      _userChoice1 = !_userChoice1;
      _userChoice2 = false;
      _userChoice3 = false;
    });
    if (_userChoice1) {
      var res = Utilities.LOW_NORMAL_WATER_USAGE *
          30 *
          Utilities.WATER_EMISSION_FACTOR;
      saveData(UtilitiesScreen.LOW_WATER_USAGE, res);
      saveData(UtilitiesScreen.LOW, _userChoice1);
      if (!tips.contains(low.id)) {
        tips.add(low);
        low.setUserSelection(true);
      } else {
        low.setUserSelection(true);
      }
    }
    if (_userChoice2 == false || _userChoice3 == false) {
      _removeData(UtilitiesScreen.HIGH);
      _removeData(UtilitiesScreen.NORMAL);
      _removeData(UtilitiesScreen.HIGH_WATER_USAGE);
      _removeData(UtilitiesScreen.NORMAL_WATER_USAGE);
      high.setUserSelection(false);
      normal.setUserSelection(false);
    }
  }

  void _selectedChoice2() {
    setState(() {
      _userChoice2 = !_userChoice2;
      _userChoice1 = false;
      _userChoice3 = false;
    });

    if (_userChoice2) {
      var res = Utilities.AVERAGE_NORMAL_WATER_USAGE *
          30 *
          Utilities.WATER_EMISSION_FACTOR;
      saveData(UtilitiesScreen.NORMAL_WATER_USAGE, res);
      saveData(UtilitiesScreen.NORMAL, _userChoice2);
      if (!tips.contains(normal.id)) {
        tips.add(normal);
        normal.setUserSelection(true);
      } else {
        normal.setUserSelection(true);
      }
    }
    if (_userChoice1 == false || _userChoice3 == false) {
      _removeData(UtilitiesScreen.LOW);
      _removeData(UtilitiesScreen.HIGH);
      _removeData(UtilitiesScreen.HIGH_WATER_USAGE);
      _removeData(UtilitiesScreen.LOW_WATER_USAGE);
      low.setUserSelection(false);
    }
  }

  void _selectedChoice3(context) {
    setState(() {
      _userChoice3 = !_userChoice3;
      _userChoice1 = false;
      _userChoice2 = false;
    });
    if (_userChoice3) {
      var res =
          Utilities.HIGH_WATER_USAGE * 30 * Utilities.WATER_EMISSION_FACTOR;
      saveData(UtilitiesScreen.HIGH_WATER_USAGE, res);
      saveData(UtilitiesScreen.HIGH, _userChoice3);
      if (!tips.contains(high.id)) {
        tips.add(high);
        high.setUserSelection(true);
      } else {
        high.setUserSelection(true);
      }
      print('selecedt high water\n');
    }
    if (_userChoice1 == false || _userChoice2 == false) {
      _removeData(UtilitiesScreen.LOW);
      _removeData(UtilitiesScreen.NORMAL);
      _removeData(UtilitiesScreen.LOW_WATER_USAGE);
      _removeData(UtilitiesScreen.NORMAL_WATER_USAGE);
      low.setUserSelection(false);
      normal.setUserSelection(false);
    }
  }

  void updateQuestionOneVal(value) {
    var res = 0.0;
    setState(() {
      _questionOneValue = value;
      res = Utilities.HEATING_EMISSION_FACTOR * _questionOneValue;
    });
    _userEnergyChoice();
    saveData(UtilitiesScreen.HEATING_VALUE, res);
  }

  void updateQuestionTwoVal(value) {
    var res = 0.0;
    setState(() {
      _questionTwoValue = value;
      res = Utilities.ELECTRICITY_EMISSION_FACTOR * _questionTwoValue;
    });
    _userEnergyChoice();
    saveData(UtilitiesScreen.ELECTRICITY_VALUE, res);
  }

  void _removeData(key) {
    removeLocalData(key);
  }

  void _userEnergyChoice() {
    if (_questionOneValue != 0 || _questionTwoValue != 0) {
      if (!tips.contains(energy.id)) {
        tips.add(energy);
        print('energy saved');
        energy.setUserSelection(true);
      } else {
        energy.setUserSelection(true);
      }
    } else {
      energy.setUserSelection(false);
    }
  }

  void removedSavedData() {
    _removeData(UtilitiesScreen.HIGH);
    _removeData(UtilitiesScreen.HIGH_WATER_USAGE);
    _removeData(UtilitiesScreen.LOW);
    _removeData(UtilitiesScreen.LOW_WATER_USAGE);
    _removeData(UtilitiesScreen.NORMAL_WATER_USAGE);
    _removeData(UtilitiesScreen.NORMAL);
    removeLocalData(UtilitiesScreen.HEATING_VALUE);
    _removeData(UtilitiesScreen.ELECTRICITY_VALUE);
    energy.setUserSelection(false);
    high.setUserSelection(false);
    low.setUserSelection(false);
    normal.setUserSelection(false);
  }
}
