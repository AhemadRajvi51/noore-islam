import android.os.Bundle;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import com.google.firebase.remoteconfig.FirebaseRemoteConfig;
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings;

public class MainActivity extends AppCompatActivity {
    private FirebaseRemoteConfig mFirebaseRemoteConfig;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Firebase Remote Config instance initialize karein
        mFirebaseRemoteConfig = FirebaseRemoteConfig.getInstance();

        // Config settings define karein
        FirebaseRemoteConfigSettings configSettings = new FirebaseRemoteConfigSettings.Builder()
                .setMinimumFetchIntervalInSeconds(3600) // 1 hour (development ke liye 0 kar sakte hain)
                .build();
        mFirebaseRemoteConfig.setConfigSettingsAsync(configSettings);

        // Default values set karein
        mFirebaseRemoteConfig.setDefaultsAsync(R.xml.remote_config_defaults);

        // Remote Config fetch aur apply karein
        fetchRemoteConfig();
    }

    private void fetchRemoteConfig() {
        mFirebaseRemoteConfig.fetchAndActivate()
                .addOnCompleteListener(this, task -> {
                    if (task.isSuccessful()) {
                        boolean updated = task.getResult();
                        Toast.makeText(this, "Config values updated: " + updated, Toast.LENGTH_SHORT).show();
                    } else {
                        Toast.makeText(this, "Fetch failed", Toast.LENGTH_SHORT).show();
                    }
                });
    }
}
