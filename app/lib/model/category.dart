abstract class Category {
  List<String> get questions;
  String get categoryTitle;
}

class Food extends Category {
  String get categoryTitle => 'Food';
  static const int RED_MEAT = 176; // KCAL/DAY
  static const int WHITE_MEAT = 140; // KCAL/DAY
  // all unit is kg C02 E
  static const int BEEF_EMISSION_FACTOR = 36;
  static const int CHICKEN_EMISSION_FACTOR = 10;
  static const int PORK_EMISSION_FACTOR = 10;
  static const int FISH_EMISSION_FACTOR = 10;
  static const int CHEESE_EMISSION_FACTOR = 13;
  static const int CHOCOLATE_EMISSION_FACTOR = 36;
  static const int OTHER_SNACK_EMISSION_FACTOR = 20;
  List<String> get questions {
    return [
      'Amount of beef, lamb, fish you eat per week',
      'Amount of chicken, pork and cheese you eat per week.',
      'Amount of drinks, chocolate and other snacks you eat per week.',
    ];
  }
}

class GoodsServices extends Category {
  static const double CLOTHES_EMISSION_FACTOR = 0.10;
  static const double HOME_APPLIANCE_EMISSION_FACTOR = 0.10;
  static const double OTHERS_EMISSION_FACTOR = 0.10;
  String get categoryTitle => 'Goods and Services';

  List<String> get questions {
    return [
      'Money spent on good per month.E.g. purchasing clothes, home appliances or other general items',
      'Amount of internet data used',
    ];
  }
}

class Utilities extends Category {
  /// all the calculation are indirect. meaning each calculation is associated with its carbon emission factor and we are just estimating. a proper way calculating is using direct formula, meaning getting all the require input (e.g. energy usage(electricity, heating value, water usage) from user and calculate carbon  footprint . this will produce a precise result. however, using indirect approach will do now in order to get an estimate value.

  String get categoryTitle => 'Utilities';
  static const double ELECTRICITY_EMISSION_FACTOR =
      0.0591; // kg c02 e per month
  static const double HIGH_WATER_USAGE =
      75.70; // litre for 20 min of high shower,car wash , ect
  static const double LOW_NORMAL_WATER_USAGE =
      5678.118; // assuming that low water usage will be half of average water usage.
  static const double AVERAGE_NORMAL_WATER_USAGE =
      11356.24; // about 11,000 litre per month or 3000 gallon per month
  static const double WATER_EMISSION_FACTOR = 0.0004; // kg C02 / litre
  static const double HEATING_EMISSION_FACTOR =
      0.031; // kg c02e /litre per month
  List<String> get questions {
    return [
      'cost of heating per month',
      'cost of electricity per month',
      'Water consumption per month'
    ];
  }
}

class Transportation extends Category {
  static const double AVERAGE_PLANE_EMISSION = 90; // kg C02 / hr
  static const double BUS_EMISSION_FACTOR = 0.204; // kg per pessenger
  static const double FUEL_EMISSION_FACTOR = 2.32; // kg c02 e / litre
  static const double CAR_EMISSION_FACTOR = 0.0003833; // kg c02 e / per month
  static const double AVERAGE_KM_PER_MONTH = 1609.34;

  String get categoryTitle => 'Transportation';
  List<String> get questions {
    return [
      'Hours spent in airplane while travelling last month ',
      'cost of fuel consumption per month. \n0 if you don’t drive.',
      'On average, how long you spend on public transportation?'
    ];
  }
}
