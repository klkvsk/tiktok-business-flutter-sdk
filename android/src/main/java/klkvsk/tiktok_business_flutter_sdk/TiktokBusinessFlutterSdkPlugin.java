package klkvsk.tiktok_business_flutter_sdk;

import android.content.Context;

import androidx.annotation.NonNull;

import com.tiktok.TikTokBusinessSdk;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

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
            case "flush":
                TikTokBusinessSdk.flush();
                result.success(null);
                break;

            case "updateAccessToken":
                String newAccessToken = call.argument("accessToken");
                if (newAccessToken != null) {
                    TikTokBusinessSdk.updateAccessToken(newAccessToken);
                }
                result.success(null);
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

                String logLevel = call.argument("logLevel");
                TikTokBusinessSdk.LogLevel ttLogLevel = null;
                if (logLevel != null) {
                    switch (logLevel) {
                        case "INFO":
                            ttLogLevel = TikTokBusinessSdk.LogLevel.INFO;
                            break;
                        case "WARN":
                            ttLogLevel = TikTokBusinessSdk.LogLevel.WARN;
                            break;
                        case "DEBUG":
                            ttLogLevel = TikTokBusinessSdk.LogLevel.DEBUG;
                            break;
                        case "NONE":
                            ttLogLevel = TikTokBusinessSdk.LogLevel.NONE;
                            break;
                    }
                }
                if (ttLogLevel == null) {
                    ttLogLevel = TikTokBusinessSdk.LogLevel.INFO;
                }

                ttConfig.setLogLevel(ttLogLevel);

                HashMap<String, Object> androidProps = call.argument("android");

                if (androidProps != null) {
                    Object disableAdvertiserIDCollection = androidProps.get("disableAdvertiserIDCollection");
                    if (disableAdvertiserIDCollection instanceof Boolean && (Boolean) disableAdvertiserIDCollection) {
                        ttConfig.disableAdvertiserIDCollection();
                    }
                    Object disableAutoEvents = androidProps.get("disableAutoEvents");
                    if (disableAutoEvents != null && (Boolean) disableAutoEvents) {
                        ttConfig.disableAutoEvents();
                    }
                    Object disableAutoStart = androidProps.get("disableAutoStart");
                    if (disableAutoStart != null && (Boolean) disableAutoStart) {
                        ttConfig.disableAutoStart();
                    }
                    Object disableInstallLogging = androidProps.get("disableInstallLogging");
                    if (disableInstallLogging != null && (Boolean) disableInstallLogging) {
                        ttConfig.disableInstallLogging();
                    }
                    Object disableLaunchLogging = androidProps.get("disableLaunchLogging");
                    if (disableLaunchLogging != null && (Boolean) disableLaunchLogging) {
                        ttConfig.disableLaunchLogging();
                    }
                    Object disableRetentionLogging = androidProps.get("disableRetentionLogging");
                    if (disableRetentionLogging != null && (Boolean) disableRetentionLogging) {
                        ttConfig.disableRetentionLogging();
                    }
                }

                TikTokBusinessSdk.initializeSdk(ttConfig);
                result.success(null);
                break;

            case "startTrack":
                TikTokBusinessSdk.startTrack();
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
