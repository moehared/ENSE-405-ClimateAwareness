import 'package:app/main.dart';
import 'package:app/model/category.dart';
import 'package:app/model/personalize_tips.dart';
import 'package:app/personalize_data/data.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:app/widget/options_button.dart';
import 'package:app/widget/quesion_card.dart';
import 'package:app/widget/unknown_button.dart';
import 'package:flutter/material.dart';

var goods = Goods(
  id: '11111',
  tip: TipData.GOODS_TIP,
  type: 'goods and services',
  subTitle: 'Reduce,reuse,recycle',
  image: 'images/goods.jpg',
);
var lessData = FewDataConsumptions(
  id: '120291',
  tip: TipData.DATA_USAGE_TIP,
  type: 'few data usage',
  subTitle: 'understand use of data',
  image: 'images/data.jpg',
);
var moreData = MoreDataConsumptions(
  id: '121191',
  tip: TipData.DATA_USAGE_TIP,
  type: 'more data usage',
  subTitle: 'understand use of data',
  image: 'images/data.jpg',
);

class GoodsServicesScreen extends StatefulWidget {
  static const String GOODS = 'GOODS AND SERVICES';
  static const String FEW_DATA = 'FEW DATA';
  static const String MORE_STREAMING = 'MORE STREAMING';
  @override
  _GoodsServicesScreenState createState() => _GoodsServicesScreenState();
}

class _GoodsServicesScreenState extends State<GoodsServicesScreen> {
  final goodsServices = GoodsServices();
  double _questionOneValue = 0.0;

  final double _max = 5000;
  final int step = 20;
  var _userChoice1 = false;
  var _userChoice2 = false;

  @override
  void initState() {
    removeLocalData(GoodsServicesScreen.GOODS);
    removeLocalData(GoodsServicesScreen.MORE_STREAMING);
    removeLocalData(GoodsServicesScreen.FEW_DATA);
    goods.setUserSelection(false);
    moreData.setUserSelection(false);
    lessData.setUserSelection(false);
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
              goodsServices.categoryTitle,
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
                  step: step,
                  question: goodsServices.questions[0],
                  value: _questionOneValue,
                  onChanged: updateQuestionOneVal,
                  button: UnknowButton(
                    onTap: () {
                      setState(() {
                        _questionOneValue = 500;
                      });
                      _userGoodsChoice();
                    },
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(goodsServices.questions[1]),
                    OptionsButton(
                      onTap: _selectedChoice1,
                      choice: 'Few data (emails, internet search)',
                      userChoice: _userChoice1,
                    ),
                    OptionsButton(
                      onTap: _selectedChoice2,
                      choice: 'A lot data (watching online videos)',
                      userChoice: _userChoice2,
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
    setState(() {
      _questionOneValue = value;
    });
    var res = _questionOneValue *
        (GoodsServices.CLOTHES_EMISSION_FACTOR +
            GoodsServices.HOME_APPLIANCE_EMISSION_FACTOR +
            GoodsServices.OTHERS_EMISSION_FACTOR);
    saveData(GoodsServicesScreen.GOODS, res);
    _userGoodsChoice();
  }

  void _userGoodsChoice() {
    if (_questionOneValue != 0.0) {
      if (!tips.contains(goods.id)) {
        tips.add(goods);
        goods.setUserSelection(true);
      } else {
        goods.setUserSelection(true);
      }
    } else {
      goods.setUserSelection(false);
    }
  }

  void _selectedChoice1() {
    setState(() {
      _userChoice1 = !_userChoice1;
      _userChoice2 = false;
    });
    if (_userChoice1) {
      var res = 0.004 + 0.001; // kg c02 e per email or search
      saveData(GoodsServicesScreen.FEW_DATA, res);
      if (!tips.contains(lessData.id)) {
        tips.add(lessData);
        lessData.setUserSelection(true);
      } else {
        lessData.setUserSelection(true);
      }
    }
    if (_userChoice2 == false) {
      moreData.setUserSelection(false);
      removeLocalData(GoodsServicesScreen.MORE_STREAMING);
    }
  }

  void _selectedChoice2() {
    setState(() {
      _userChoice2 = !_userChoice2;
      _userChoice1 = false;
    });

    if (_userChoice2) {
      var res =
          0.082; // watching more than 30 min video produces about 0.082 kg c02 e
      saveData(GoodsServicesScreen.MORE_STREAMING, res);
      if (!tips.contains(moreData.id)) {
        tips.add(moreData);
        moreData.setUserSelection(true);
      } else {
        moreData.setUserSelection(true);
      }
    }
    if (_userChoice1 == false) {
      lessData.setUserSelection(false);
      removeLocalData(GoodsServicesScreen.FEW_DATA);
    }
  }
}
