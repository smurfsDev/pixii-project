import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

class Environment {
  static String apiUrl = kIsWeb
      ? 'http://localhost:8081' // for Web
      : Platform.isAndroid
          ? 'http://192.168.1.5:8081' // for Android
          : 'http://localhost:8081'; // for Others

  static String socketUrl = kIsWeb
      ? 'http://localhost:8081' // for Web
      : Platform.isAndroid
          ? 'http://192.168.1.5:8081' // for Android
          : 'http://localhost:8081'; // for Others
}
