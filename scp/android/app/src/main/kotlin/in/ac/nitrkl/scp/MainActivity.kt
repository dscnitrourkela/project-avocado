package `in`.ac.nitrkl.scp.scp

import `in`.ac.nitrkl.scp.FaqActivity
import android.content.Intent
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    final var CHANNEL = "FAQ_ACTIVITY"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method.equals("startFaqActivity", ignoreCase = true)) {
                startActivity(Intent(this, FaqActivity::class.java))
            }
        }
    }
}