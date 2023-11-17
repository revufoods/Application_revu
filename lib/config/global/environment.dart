import 'dart:io';

class Environment {
  static String apiURL =
      Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://10.0.2.2:8000';
}
