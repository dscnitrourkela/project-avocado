package in.ac.nitrkl.scp;

import android.os.Bundle;
import android.widget.Toast;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "FAQ_ACTIVITY";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                    (call, result) -> {
                        if (call.method.equalsIgnoreCase("startFaqActivity")) {
                            Toast.makeText(getApplicationContext(), "Working", Toast.LENGTH_SHORT).show();
                        }
                }
        );
    }
}

