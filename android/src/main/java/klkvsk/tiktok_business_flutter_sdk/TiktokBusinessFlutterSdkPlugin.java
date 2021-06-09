package klkvsk.tiktok_business_flutter_sdk;

import android.content.Context;

import androidx.annotation.NonNull;

import com.tiktok.TikTokBusinessSdk;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * TiktokBusinessFlutterSdkPlugin
 */
public class TiktokBusinessFlutterSdkPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tiktok_business_flutter_sdk");
        channel.setMethodCallHandler(this);
        context = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        switch (call.method) {
            case "clearAll":
                TikTokBusinessSdk.clearAll();
                result.success(null);
                break;

            case "destroy":
                TikTokBusinessSdk.destroy();
                result.success(null);
                break;

            case "flush":
                TikTokBusinessSdk.flush();
                result.success(null);
                break;

            case "getAccessToken":
                String accessToken = TikTokBusinessSdk.getAccessToken();
                result.success(accessToken);
                break;

            case "updateAccessToken":
                String newAccessToken = call.argument("accessToken");
                TikTokBusinessSdk.updateAccessToken(newAccessToken);
                result.success(null);
                break;

            case "getApiAvailableVersion":
                String apiAvailableVersion = TikTokBusinessSdk.getApiAvailableVersion();
                result.success(apiAvailableVersion);
                break;

            case "setApiAvailableVersion":
                String version = call.argument("version");
                TikTokBusinessSdk.setApiAvailableVersion(version);
                result.success(null);
                break;

            case "getAppId":
                String appId = TikTokBusinessSdk.getAppId();
                result.success(appId);
                break;

            case "initializeSdk":
                if (context == null) {
                    result.error(
                            "ERR_NO_CONTEXT",
                            "Application context was not set before initializeSdk()",
                            null
                    );
                    break;
                }
                TikTokBusinessSdk.TTConfig ttConfig = new TikTokBusinessSdk.TTConfig(context);
                ttConfig.setAppId((String) call.argument("appId"));
                ttConfig.setAccessToken((String) call.argument("accessToken"));
                ttConfig.setLogLevel(TikTokBusinessSdk.LogLevel.valueOf("NONE"));
                if ((boolean) call.argument("disableAdvertiserIDCollection")) {
                    ttConfig.disableAdvertiserIDCollection();
                }
                if ((boolean) call.argument("disableAutoEvents")) {
                    ttConfig.disableAutoEvents();
                }
                if ((boolean) call.argument("disableAutoStart")) {
                    ttConfig.disableAutoStart();
                }
                if ((boolean) call.argument("disableInstallLogging")) {
                    ttConfig.disableInstallLogging();
                }
                if ((boolean) call.argument("disableLaunchLogging")) {
                    ttConfig.disableLaunchLogging();
                }
                if ((boolean) call.argument("disableRetentionLogging")) {
                    ttConfig.disableRetentionLogging();
                }

                TikTokBusinessSdk.initializeSdk(ttConfig);
                result.success(null);
                break;

            case "getLogLevel":
                TikTokBusinessSdk.LogLevel logLevel = TikTokBusinessSdk.getLogLevel();
                result.success(logLevel.name());
                break;

            case "startTrack":
                TikTokBusinessSdk.startTrack();
                result.success(null);
                break;

            case "getNetworkSwitch":
                boolean networkSwitch = TikTokBusinessSdk.getNetworkSwitch();
                result.success(networkSwitch);
                break;

            case "isGlobalConfigFetched":
                boolean isGlobalConfigFetched = TikTokBusinessSdk.isGlobalConfigFetched();
                result.success(isGlobalConfigFetched);
                break;

            case "setGlobalConfigFetched":
                TikTokBusinessSdk.setGlobalConfigFetched();
                result.success(null);
                break;

            case "isGaidCollectionEnabled":
                boolean isGaidCollectionEnabled = TikTokBusinessSdk.isGaidCollectionEnabled();
                result.success(isGaidCollectionEnabled);
                break;

            case "isInitialized":
                boolean isInitialized = TikTokBusinessSdk.isInitialized();
                result.success(isInitialized);
                break;

            case "isSystemActivated":
                boolean isSystemActivated = TikTokBusinessSdk.isSystemActivated();
                result.success(isSystemActivated);
                break;

            case "getSdkGlobalSwitch":
                boolean sdkGlobalSwitch = TikTokBusinessSdk.getSdkGlobalSwitch();
                result.success(sdkGlobalSwitch);
                break;

            case "setSdkGlobalSwitch":
                Boolean newSdkGlobalSwitch = call.argument("sdkGlobalSwitch");
                TikTokBusinessSdk.setSdkGlobalSwitch(newSdkGlobalSwitch);
                result.success(null);
                break;

            case "logout":
                TikTokBusinessSdk.logout();
                result.success(null);
                break;

            case "trackEvent":
                String event = call.argument("event");
                String propsEncoded = call.argument("props");
                if (propsEncoded == null) {
                    TikTokBusinessSdk.trackEvent(event);
                } else {
                    try {
                        JSONObject propsObject = new JSONObject(propsEncoded);
                        TikTokBusinessSdk.trackEvent(event, propsObject);
                        result.success(null);
                    } catch (JSONException e) {
                        result.error("ERR_JSON_MALFORMED", e.toString(), null);
                    }
                }
                break;

            case "identify":
                String externalId = call.argument("externalId");
                String externalUserName = call.argument("externalUserName");
                String phoneNumber = call.argument("phoneNumber");
                String email = call.argument("email");
                TikTokBusinessSdk.identify(externalId, externalUserName, phoneNumber, email);
                result.success(null);
                break;

            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        context = null;
    }
}
