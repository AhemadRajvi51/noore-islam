import android.app.Application;
import com.google.firebase.remoteconfig.FirebaseRemoteConfig;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings;

public class MyApp extends Application {
    private static FirebaseRemoteConfig mFirebaseRemoteConfig;

    @Override
    public void onCreate() {
        super.onCreate();

        // 🔹 FirebaseRemoteConfig ka Instance Initialize Karo
        mFirebaseRemoteConfig = FirebaseRemoteConfig.getInstance();

        // 🔹 Config Settings Set Karo
        FirebaseRemoteConfigSettings configSettings = new FirebaseRemoteConfigSettings.Builder()
                .setMinimumFetchIntervalInSeconds(3600) // 1 hour
                .build();
        mFirebaseRemoteConfig.setConfigSettingsAsync(configSettings);

        // 🔹 Default Values Set Karo
        mFirebaseRemoteConfig.setDefaultsAsync(R.xml.remote_config_defaults);
    }

    public static FirebaseRemoteConfig getRemoteConfig() {
        return mFirebaseRemoteConfig;
    }
}
