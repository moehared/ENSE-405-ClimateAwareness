import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

abstract class PersonalizedTip with ChangeNotifier {
  static const String TIPS_KEY = "TIPS_KEY";
  final String id;
  final String type;
  bool userChoice;
  final String tip;
  final String subTitle;
  final String image;
  final String learnMore;

  PersonalizedTip(this.id, this.type, this.userChoice, this.tip, this.subTitle,
      this.image, this.learnMore);
  void setUserSelection(bool choice) {}
  Map<String, dynamic> toJson() => null;
  PersonalizedTip.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        subTitle = json['subTitle'],
        type = json['type'],
        tip = json['tip'],
        userChoice = json['userChoice'],
        learnMore = json['learn'];
}

class HighWaterUsage extends PersonalizedTip {
  HighWaterUsage(
      {String id,
      String type,
      bool userChoice = false,
      String tip,
      String subTitle,
      String image,
      String learnMore =
          "https://www.volusia.org/services/growth-and-resource-management/environmental-management/natural-resources/water-conservation/25-ways-to-save-water.stml"})
      : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}

class LowWaterUsage extends PersonalizedTip {
  LowWaterUsage({
    String id,
    String type,
    bool userChoice = false,
    String tip,
    String subTitle,
    String image,
    String learnMore =
        "https://www.volusia.org/services/growth-and-resource-management/environmental-management/natural-resources/water-conservation/25-ways-to-save-water.stml",
  }) : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}

class NormalWaterUsage extends PersonalizedTip {
  NormalWaterUsage({
    String id,
    String type,
    bool userChoice = false,
    String tip,
    String subTitle,
    String image,
    String learnMore =
        "https://www.volusia.org/services/growth-and-resource-management/environmental-management/natural-resources/water-conservation/25-ways-to-save-water.stml",
  }) : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}

class Drive extends PersonalizedTip {
  Drive({
    String id,
    String type,
    bool userChoice = false,
    String tip,
    String subTitle,
    String image,
    String learnMore =
        "https://www.c2es.org/content/reducing-your-transportation-footprint/",
  }) : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}

class AirPlane extends PersonalizedTip {
  AirPlane({
    String id,
    String type,
    bool userChoice = false,
    String tip,
    String subTitle,
    String image,
    String learnMore = "https://www.bbc.com/news/science-environment-49349566",
  }) : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}

class PublicTransportation extends PersonalizedTip {
  PublicTransportation({
    String id,
    String type,
    bool userChoice = false,
    String tip,
    String subTitle,
    String image,
    String learnMore =
        "https://www.c2es.org/content/reducing-your-transportation-footprint/",
  }) : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}

class FoodConsumption extends PersonalizedTip {
  FoodConsumption({
    String id,
    String type,
    bool userChoice = false,
    String tip,
    String subTitle,
    String image,
    String learnMore =
        "https://davidsuzuki.org/queen-of-green/food-climate-change/",
  }) : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}

class Goods extends PersonalizedTip {
  Goods({
    String id,
    String type,
    bool userChoice = false,
    String tip,
    String subTitle,
    String image,
    String learnMore =
        "https://newrepublic.com/article/154147/climate-change-symptom-consumer-culture-disease",
  }) : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}

class FewDataConsumptions extends PersonalizedTip {
  FewDataConsumptions({
    String id,
    String type,
    bool userChoice = false,
    String tip,
    String subTitle,
    String image,
    String learnMore =
        "https://www.bbc.com/future/article/20200305-why-your-internet-habits-are-not-as-clean-as-you-think",
  }) : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}

class MoreDataConsumptions extends PersonalizedTip {
  MoreDataConsumptions({
    String id,
    String type,
    bool userChoice = false,
    String tip,
    String subTitle,
    String image,
    String learnMore =
        "https://www.bbc.com/future/article/20200305-why-your-internet-habits-are-not-as-clean-as-you-think",
  }) : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}

class EnergyConsumption extends PersonalizedTip {
  EnergyConsumption({
    String id,
    String type,
    bool userChoice = false,
    String tip,
    String subTitle,
    String image,
    String learnMore =
        "https://energysavingtrust.org.uk/advice/home-appliances/",
  }) : super(id, type, userChoice, tip, subTitle, image, learnMore);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'image': this.image,
      'subtitle': this.subTitle,
      'tip': this.tip,
      'userChoice': this.userChoice,
      'learn': this.learnMore
    };
  }

  @override
  void setUserSelection(bool choice) {
    this.userChoice = choice;
    notifyListeners();
  }
}
