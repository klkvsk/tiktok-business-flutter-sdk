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

  static Future<String> get accessToken async {
    return await _channel.invokeMethod('getAccessToken');
  }

  static Future<String> get appId async {
    return await _channel.invokeMethod('getAppId');
  }

  static Future<String> get apiAvailableVersion async {
    return await _channel.invokeMethod('getApiAvailableVersion');
  }

  static Future<void> setApiAvailableVersion(String version) async {
    return await _channel
        .invokeMethod('setApiAvailableVersion', {'version': version});
  }

  static Future<bool> get networkSwitch async {
    return await _channel.invokeMethod('getNetworkSwitch');
  }

  static Future<bool> get sdkGlobalSwitch async {
    return await _channel.invokeMethod('getSdkGlobalSwitch');
  }

  static Future<void> setSdkGlobalSwitch(bool sdkGlobalSwitch) async {
    return await _channel.invokeMethod(
        'setSdkGlobalSwitch', {'sdkGlobalSwitch': sdkGlobalSwitch});
  }

  static Future<bool> get isGlobalConfigFetched async {
    return await _channel.invokeMethod('isGlobalConfigFetched');
  }

  static Future<void> setGlobalConfigFetched(String version) async {
    return await _channel.invokeMethod('setGlobalConfigFetched');
  }

  static Future<bool> get isGaidCollectionEnabled async {
    return await _channel.invokeMethod('isGlobalConfigFetched');
  }

  static Future<bool> get isInitialized async {
    return await _channel.invokeMethod('isInitialized');
  }

  static Future<bool> get isSystemActivated async {
    return await _channel.invokeMethod('isSystemActivated');
  }

  static Future<String> get logLevel async {
    return await _channel.invokeMethod('getLogLevel');
  }

  static Future<void> clearAll() async {
    return await _channel.invokeMethod('clearAll');
  }

  static Future<void> flush() async {
    return await _channel.invokeMethod('flush');
  }

  static Future<void> destroy() async {
    return await _channel.invokeMethod('destroy');
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
    bool disableAdvertiserIDCollection = false,
    bool disableAutoEvents = false,
    bool disableAutoStart = false,
    bool disableInstallLogging = false,
    bool disableLaunchLogging = false,
    bool disableRetentionLogging = false,
  }) async {
    await _channel.invokeMethod("initializeSdk", {
      'appId': appId,
      'accessToken': accessToken,
      'logLevel': logLevel,
      'disableAdvertiserIDCollection': disableAdvertiserIDCollection,
      'disableAutoEvents': disableAutoEvents,
      'disableAutoStart': disableAutoStart,
      'disableInstallLogging': disableInstallLogging,
      'disableLaunchLogging': disableLaunchLogging,
      'disableRetentionLogging': disableRetentionLogging,
    });
  }

  static Future<void> startTrack() async {
    return await _channel.invokeMethod('startTrack');
  }
}
