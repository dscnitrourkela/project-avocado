package `in`.ac.nitrkl.scp.scp

import SplashView
import `in`.ac.nitrkl.scp.FaqActivity
import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.SplashScreen
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity:FlutterActivity() {
   override fun configureFlutterEngine(@NonNull flutterEngine:FlutterEngine) {
      GeneratedPluginRegistrant.registerWith(flutterEngine)
      MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
      .setMethodCallHandler(
        { call, result->  if (call.method.equals("startFaqActivity", ignoreCase = true)) {
            startActivity(Intent(this, FaqActivity::class.java))
        } }
      )
    }

    override fun provideSplashScreen(): SplashScreen? = SplashView()

    companion object {
      private val CHANNEL = "FAQ_ACTIVITY"
    }
  }

