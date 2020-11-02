package io.flutter.plugins.firebasemessagingexample;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import androidx.annotation.NonNull;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterActivity;

public class Application extends FlutterApplication{


    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}

