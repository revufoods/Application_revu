echo "
/*
--------------------------------------------
GENERATED FILE DO NOT EDIT
--------------------------------------------
*/

import 'dart:io';

class Environment {
  static String apiURL = Platform.isAndroid
      ? '${SERVER_BASE_URL}'
      : '${SERVER_BASE_URL}';
}
" > environment.dart
