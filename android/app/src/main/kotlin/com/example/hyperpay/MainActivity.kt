package com.example.aarsh_hyperpay

import android.os.Bundle
import android.provider.Settings;
import android.util.Log;
import io.flutter.embedding.android.FlutterActivity


class MainActivity : FlutterActivity() {
    protected override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            val enabledInputMethods: String = Settings.Secure.getString(
                getContentResolver(),
                Settings.Secure.ENABLED_INPUT_METHODS
            )
            Log.d("App", "Enabled Input Methods: $enabledInputMethods")
        } catch (e: SecurityException) {
            Log.e("App", "Access denied to enabled_input_methods on targetSdkVersion >= 33.")
        }
    }
}
