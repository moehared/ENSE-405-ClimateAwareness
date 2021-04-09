import 'dart:convert';

import 'package:app/model/personalize_tips.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/questionaire_screen/food_screen.dart';
import 'package:app/screens/questionaire_screen/goods_services_screen.dart';
import 'package:app/screens/questionaire_screen/questinaires_screen.dart';
import 'package:app/screens/questionaire_screen/transportation.dart';
import 'package:app/screens/questionaire_screen/utilities_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

void saveData(String key, var data) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  if (data is double) {
    pref.setDouble(key, data);
  }
  if (data is bool) {
    pref.setBool(key, data);
  }

  if (data is Set<PersonalizedTip> && data != null) {
    pref.setString(key, json.encode(jsonEncodeTips()));
  }

  if (data is String) {
    pref.setString(key, data);
  }
}

Future getLocalData(String key) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  switch (key) {
    case UtilitiesScreen.HEATING_VALUE:
      return pref.getDouble(key);
    case UtilitiesScreen.ELECTRICITY_VALUE:
      return pref.getDouble(key);
    case TransportationScreen.AIRPLANE_VALUE:
      return pref.getDouble(key);
    case TransportationScreen.FUEL_VALUE:
      return pref.getDouble(key);
    case FoodScreen.RED_MEAT_VALUE:
      return pref.getDouble(key);
    case FoodScreen.WHITE_MEAT_VALUE:
      return pref.getDouble(key);
    case FoodScreen.OTHER_SNACKS:
      return pref.getDouble(key);
    case GoodsServicesScreen.GOODS:
      return pref.getDouble(key);
    case GoodsServicesScreen.FEW_DATA:
      return pref.getDouble(key);
    case GoodsServicesScreen.MORE_STREAMING:
      return pref.getDouble(key);
    case UtilitiesScreen.LOW:
      return pref.getBool(key);
    case UtilitiesScreen.NORMAL:
      return pref.getBool(key);
    case UtilitiesScreen.HIGH:
      return pref.getBool(key);
    case UtilitiesScreen.NORMAL_WATER_USAGE:
      return pref.getDouble(key);
    case UtilitiesScreen.LOW_WATER_USAGE:
      return pref.getDouble(key);
    case UtilitiesScreen.HIGH_WATER_USAGE:
      return pref.getDouble(key);
    case TransportationScreen.OPTION1:
      return pref.getDouble(key);
    case TransportationScreen.OPTION2:
      return pref.getDouble(key);
    case TransportationScreen.OPTION3:
      return pref.getDouble(key);
    case TransportationScreen.OPTION4:
      return pref.getDouble(key);
    case QuestinairesScreen.RESULT:
      return pref.getDouble(key);
    case ProfileScreen.IMAGE_KEY:
      return pref.getString(key);
    case PersonalizedTip.TIPS_KEY:
      return json.decode(pref.getString(key));
  }
}

Future<void> removeLocalData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

List<Map<String, dynamic>> jsonEncodeTips() {
  return tips.map((e) {
    return e.toJson();
  }).toList();
}
