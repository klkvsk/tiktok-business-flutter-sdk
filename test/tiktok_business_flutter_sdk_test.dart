import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_business_flutter_sdk/tiktok_business_flutter_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('tiktok_business_flutter_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TikTokBusinessFlutterSdk.apiAvailableVersion, '42');
  });
}
