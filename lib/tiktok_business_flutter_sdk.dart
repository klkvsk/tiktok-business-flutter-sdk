
import 'dart:async';

import 'package:flutter/services.dart';

class TiktokBusinessFlutterSdk {
  static const MethodChannel _channel =
      const MethodChannel('tiktok_business_flutter_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
