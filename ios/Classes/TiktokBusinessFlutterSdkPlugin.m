#import "TiktokBusinessFlutterSdkPlugin.h"
#import "TikTokBusinessSDK.h"

@implementation TiktokBusinessFlutterSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"tiktok_business_flutter_sdk"
                                     binaryMessenger:[registrar messenger]];
    TiktokBusinessFlutterSdkPlugin* instance = [[TiktokBusinessFlutterSdkPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"initializeSdk" isEqualToString:call.method]) {
        NSString* appId = call.arguments[@"appId"];
        NSString* accessToken = call.arguments[@"accessToken"];
        NSNumber* tiktokAppId = call.arguments[@"tiktokAppId"];
        TikTokConfig *config = [TikTokConfig configWithAccessToken:accessToken appId:appId tiktokAppId:tiktokAppId];
        
        NSString* logLevel = call.arguments[@"logLevel"];
        TikTokLogLevel ttLogLevel = TikTokLogLevelInfo;
        if (logLevel != nil) {
            if ([@"DEBUG" isEqualToString:logLevel]) {
                ttLogLevel = TikTokLogLevelVerbose;
            }
            else if ([@"INFO" isEqualToString:logLevel]) {
                ttLogLevel = TikTokLogLevelInfo;
            }
            else if ([@"WARN" isEqualToString:logLevel]) {
                ttLogLevel = TikTokLogLevelWarn;
            }
            else if ([@"NONE" isEqualToString:logLevel]) {
                ttLogLevel = TikTokLogLevelSuppress;
            }
        }
        
        [config setLogLevel:ttLogLevel];
        
        NSDictionary* iosProps = call.arguments[@"ios"];
        if (iosProps != nil) {
            NSNumber* disableTracking = iosProps[@"disableTracking"];
            if (disableTracking != nil && [disableTracking boolValue]) {
                [config disableTracking];
            }
            
            NSNumber* disableLaunchTracking = iosProps[@"disableLaunchTracking"];
            if (disableLaunchTracking != nil && [disableLaunchTracking boolValue]) {
                [config disableLaunchTracking];
            }
            
            NSNumber* disableInstallTracking = iosProps[@"disableInstallTracking"];
            if (disableInstallTracking != nil && [disableInstallTracking boolValue]) {
                [config disableInstallTracking];
            }
            
            NSNumber* disableAutomaticTracking = iosProps[@"disableAutomaticTracking"];
            if (disableAutomaticTracking != nil && [disableAutomaticTracking boolValue]) {
                [config disableAutomaticTracking];
            }
            
            NSNumber* disableRetentionTracking = iosProps[@"disableRetentionTracking"];
            if (disableRetentionTracking != nil && [disableRetentionTracking boolValue]) {
                [config disableRetentionTracking];
            }
            
            NSNumber* disablePaymentTracking = iosProps[@"disablePaymentTracking"];
            if (disablePaymentTracking != nil && [disablePaymentTracking boolValue]) {
                [config disablePaymentTracking];
            }
            
            NSNumber* disableAppTrackingDialog = iosProps[@"disableAppTrackingDialog"];
            if (disableAppTrackingDialog != nil && [disableAppTrackingDialog boolValue]) {
                [config disableAppTrackingDialog];
            }
            
            NSNumber* disableSKAdNetworkSupport = iosProps[@"disableAppTrackingDialog"];
            if (disableSKAdNetworkSupport != nil && [disableSKAdNetworkSupport boolValue]) {
                [config disableSKAdNetworkSupport];
            }
            
            NSString* customUserAgent = iosProps[@"customUserAgent"];
            if (customUserAgent != nil) {
                [config setCustomUserAgent:customUserAgent];
            }
            
            NSNumber* delayForATTUserAuthorizationInSeconds = call.arguments[@"delayForATTUserAuthorizationInSeconds"];
            if (delayForATTUserAuthorizationInSeconds != nil) {
                [config setDelayForATTUserAuthorizationInSeconds:[delayForATTUserAuthorizationInSeconds longValue]];
            }
        }
        
        [TikTokBusiness initializeSdk:config];
        result(nil);
    
    } else if ([@"updateAccessToken" isEqualToString:call.method]) {
        NSString* newAccessToken = call.arguments[@"accessToken"];
        [TikTokBusiness updateAccessToken:newAccessToken];
    
    } else if ([@"flush" isEqualToString:call.method]) {
        [TikTokBusiness explicitlyFlush];
    
    } else if ([@"logout" isEqualToString:call.method]) {
        [TikTokBusiness logout];
    
    } else if ([@"identify" isEqualToString:call.method]) {
        NSString* externalId = call.arguments[@"externalId"];
        NSString* phoneNumber = call.arguments[@"phoneNumber"];
        NSString* email = call.arguments[@"email"];
        [TikTokBusiness identifyWithExternalID:externalId phoneNumber:phoneNumber email:email];
    
    } else if ([@"startTrack" isEqualToString:call.method]) {
        [TikTokBusiness setTrackingEnabled:YES];
        [TikTokBusiness explicitlyFlush];
        
    } else if ([@"trackEvent" isEqualToString:call.method]) {
        NSString* event = call.arguments[@"event"];
        NSString* propsEncoded = call.arguments[@"props"];
        if (event != nil) {
            if (propsEncoded == nil) {
                [TikTokBusiness trackEvent:event];
            } else {
                NSData *propsEncodedData = [propsEncoded dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error;
                NSDictionary *propsDict = [NSJSONSerialization JSONObjectWithData:propsEncodedData options:0 error:&error];
                if (error != nil) {
                    result([FlutterError
                            errorWithCode:@"ERR_JSON_MALFORMED"
                            message:error.localizedDescription details:nil
                            ]);
                } else {
                    [TikTokBusiness trackEvent:event withProperties:propsDict];
                }
            }
        }
        
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
