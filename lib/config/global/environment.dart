import 'dart:io';

class Environment {
  static String apiURL =
      Platform.isAndroid ? 'https://api.revu-foods.com' : 'https://api.revu-foods.com';
}
