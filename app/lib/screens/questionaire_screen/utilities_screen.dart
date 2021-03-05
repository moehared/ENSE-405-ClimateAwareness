import 'package:app/model/category.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:app/widget/options_button.dart';
import 'package:app/widget/quesion_card.dart';
import 'package:app/widget/unknown_button.dart';
import 'package:flutter/material.dart';

class UtilitiesScreen extends StatefulWidget {
  static const String HEATING_VALUE = 'HEATING';
  static const String ELECTRICITY_VALUE = 'ELECTRICITY';
  static const String LOW = 'LOW';
  static const String NORMAL = 'NORMAL';
  static const String HIGH = 'HIGH';

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
                    },
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(utilities.questions[2]),
                    OptionsButton(
                      onTap: _selectedChoice1,
                      choice: 'Low e.g. less shower, less water usage',
                      userChoice: _userChoice1,
                    ),
                    OptionsButton(
                      onTap: _selectedChoice2,
                      choice: 'Normal',
                      userChoice: _userChoice2,
                    ),
                    OptionsButton(
                      onTap: _selectedChoice3,
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

  void _selectedChoice1() {
    setState(() {
      _userChoice1 = !_userChoice1;
      _userChoice2 = false;
      _userChoice3 = false;
    });
    saveData(UtilitiesScreen.LOW, _userChoice1);
  }

  void _selectedChoice2() {
    setState(() {
      _userChoice2 = !_userChoice2;
      _userChoice1 = false;
      _userChoice3 = false;
    });
    saveData(UtilitiesScreen.NORMAL, _userChoice2);
  }

  void _selectedChoice3() {
    setState(() {
      _userChoice3 = !_userChoice3;
      _userChoice1 = false;
      _userChoice2 = false;
    });
    saveData(UtilitiesScreen.HIGH, _userChoice3);
  }

  void updateQuestionOneVal(value) {
    var res = 0.0;
    setState(() {
      _questionOneValue = value;
      res = Utilities.HEATING_EMISSION_FACTOR * _questionOneValue;
    });
    saveData(UtilitiesScreen.HEATING_VALUE, res);
  }

  void updateQuestionTwoVal(value) {
    var res = 0.0;
    setState(() {
      _questionTwoValue = value;
      res = Utilities.ELECTRICITY_EMISSION_FACTOR * _questionTwoValue;
    });
    saveData(UtilitiesScreen.ELECTRICITY_VALUE, res);
  }

  void _removeData(key) {
    removeLocalData(key);
  }
}
