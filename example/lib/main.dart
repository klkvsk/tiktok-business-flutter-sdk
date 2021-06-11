import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tiktok_business_flutter_sdk/tiktok_business_flutter_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _debugInfo = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    TikTokBusinessFlutterSdk.initializeSdk(
        appId: 'com.test.app',
        accessToken: 'access_token',
        logLevel: TikTokBusinessFlutterSdk.LOG_LEVEL_DEBUG);

    TikTokBusinessFlutterSdk.trackEvent('simpleEventTest');
    TikTokBusinessFlutterSdk.trackEvent('parametrizedEventTest', {
      'name': 'John',
      'age': 25,
      'verified': true,
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _debugInfo = "ALL OK";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('$_debugInfo\n'),
        ),
      ),
    );
  }
}
