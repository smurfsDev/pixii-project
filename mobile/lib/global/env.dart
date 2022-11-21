import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

class Environment {
  static String apiUrl = kIsWeb
      ? 'http://localhost:8081' // for Web
      : Platform.isAndroid
          ? 'http://172.17.100.2:8081' // for Android
          : 'http://localhost:8081'; // for Others

  static String socketUrl = kIsWeb
      ? 'http://localhost:8081' // for Web
      : Platform.isAndroid
          ? 'http://172.17.100.2:8081' // for Android
          : 'http://localhost:8081'; // for Others
}