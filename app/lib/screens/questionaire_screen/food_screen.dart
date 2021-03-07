import 'package:app/model/category.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:app/widget/quesion_card.dart';
import 'package:flutter/material.dart';

class FoodScreen extends StatefulWidget {
  static const String RED_MEAT_VALUE = 'RED_MEAT_VALUE';
  static const String WHITE_MEAT_VALUE = 'WHITE_MEAT_VALUE';
  static const String OTHER_SNACKS = 'OTHER_SNACKS';
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final food = Food();
  double _questionOneValue = 0.0;
  double _questionTwoValue = 0.0;
  double _questionThreeValue = 0.0;

  final double _max = 16;
  final int _step = 8;

  @override
  void initState() {
    removeLocalData(FoodScreen.OTHER_SNACKS);
    removeLocalData(FoodScreen.RED_MEAT_VALUE);
    removeLocalData(FoodScreen.WHITE_MEAT_VALUE);
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
              food.categoryTitle,
              style: TextStyle(fontFamily: 'Roboto-'),
            ),
          ),
          Container(
            height: media.size.height * 0.70,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                QuestionCard(
                    max: _max,
                    step: _step,
                    question: food.questions[0],
                    value: _questionOneValue,
                    onChanged: updateQuestionOneVal,
                    button: Container()),
                QuestionCard(
                  max: _max,
                  step: _step,
                  question: food.questions[1],
                  value: _questionTwoValue,
                  onChanged: updateQuestionTwoVal,
                  button: Container(),
                ),
                QuestionCard(
                  max: _max,
                  step: _step,
                  question: food.questions[2],
                  value: _questionThreeValue,
                  onChanged: updateQuestionThreeVal,
                  button: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateQuestionOneVal(value) {
    setState(() {
      _questionOneValue = value;
    });
    var res = _questionOneValue *
        (Food.RED_MEAT + Food.BEEF_EMISSION_FACTOR + Food.FISH_EMISSION_FACTOR);
    saveData(FoodScreen.RED_MEAT_VALUE, res);
  }

  void updateQuestionTwoVal(value) {
    setState(() {
      _questionTwoValue = value;
    });

    var res = _questionTwoValue * (Food.CHICKEN_EMISSION_FACTOR) +
        (Food.WHITE_MEAT +
            Food.PORK_EMISSION_FACTOR +
            Food.CHEESE_EMISSION_FACTOR);
    saveData(FoodScreen.WHITE_MEAT_VALUE, res);
  }

  void updateQuestionThreeVal(value) {
    setState(() {
      _questionThreeValue = value;
    });
    var res = _questionThreeValue *
        (Food.OTHER_SNACK_EMISSION_FACTOR + Food.CHOCOLATE_EMISSION_FACTOR);
    saveData(FoodScreen.OTHER_SNACKS, res);
  }
}
