package com.example.my_app

import com.example.asr.plugin.asr.AsrPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    /**
     * 插件的使用
     * 注册插件
     */
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        AsrPlugin.registerWith(this, flutterEngine.dartExecutor.binaryMessenger)
    }
}
