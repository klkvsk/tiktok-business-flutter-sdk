import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class TikTokBusinessFlutterSdk {
  static const String LOG_LEVEL_NONE = "NONE";
  static const String LOG_LEVEL_INFO = "INFO";
  static const String LOG_LEVEL_WARN = "WARN";
  static const String LOG_LEVEL_DEBUG = "DEBUG";

  static const MethodChannel _channel =
      const MethodChannel('tiktok_business_flutter_sdk');

  static Future<void> flush() async {
    return await _channel.invokeMethod('flush');
  }

  static Future<void> logout() async {
    return await _channel.invokeMethod('logout');
  }

  static Future<void> trackEvent(String event, [Map props]) async {
    String propsEncoded = (props != null) ? json.encode(props) : null;
    return await _channel
        .invokeMethod('trackEvent', {'event': event, 'props': propsEncoded});
  }

  static Future<void> identify(String externalId,
      {String externalUserName, String phoneNumber, String email}) async {
    return await _channel.invokeMethod('identify', {
      'externalId': externalId,
      'externalUserName': externalUserName,
      'phoneNumber': phoneNumber,
      'email': email,
    });
  }

  static Future<void> updateAccessToken(String accessToken) async {
    return await _channel
        .invokeMethod('updateAccessToken', {'accessToken': accessToken});
  }

  static Future<void> initializeSdk({
    String appId,
    String accessToken,
    String logLevel = LOG_LEVEL_INFO,
    bool android_disableAdvertiserIDCollection = false,
    bool android_disableAutoEvents = false,
    bool android_disableAutoStart = false,
    bool android_disableInstallLogging = false,
    bool android_disableLaunchLogging = false,
    bool android_disableRetentionLogging = false,
    bool ios_disableTracking = false,
    bool ios_disableLaunchTracking = false,
    bool ios_disableInstallTracking = false,
    bool ios_disableAutomaticTracking = false,
    bool ios_disableRetentionTracking = false,
    bool ios_disablePaymentTracking = false,
    bool ios_disableAppTrackingDialog = false,
    bool ios_disableSKAdNetworkSupport = false,
    String ios_customUserAgent = null,
    int ios_delayForATTUserAuthorizationInSeconds = null,
  }) async {
    await _channel.invokeMethod("initializeSdk", {
      'appId': appId,
      'accessToken': accessToken,
      'logLevel': logLevel,
      'android': {
        'disableAdvertiserIDCollection': android_disableAdvertiserIDCollection,
        'disableAutoEvents': android_disableAutoEvents,
        'disableAutoStart': android_disableAutoStart,
        'disableInstallLogging': android_disableInstallLogging,
        'disableLaunchLogging': android_disableLaunchLogging,
        'disableRetentionLogging': android_disableRetentionLogging,
      },
      'ios': {
        'disableTracking': ios_disableTracking,
        'disableLaunchTracking': ios_disableLaunchTracking,
        'disableInstallTracking': ios_disableInstallTracking,
        'disableAutomaticTracking': ios_disableAutomaticTracking,
        'disableRetentionTracking': ios_disableRetentionTracking,
        'disablePaymentTracking': ios_disablePaymentTracking,
        'disableAppTrackingDialog': ios_disableAppTrackingDialog,
        'disableSKAdNetworkSupport': ios_disableSKAdNetworkSupport,
        'ios_customUserAgent': ios_customUserAgent,
        'ios_delayForATTUserAuthorizationInSeconds':
            ios_delayForATTUserAuthorizationInSeconds,
      }
    });
  }

  static Future<void> startTrack() async {
    return await _channel.invokeMethod('startTrack');
  }
}
