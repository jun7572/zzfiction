package com.june.fiction

import android.content.Context
import android.os.Build
import androidx.multidex.MultiDex
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class MyApplication : FlutterApplication() {

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }

    override fun onCreate() {
        super.onCreate()
    }

//    override fun registerWith(registry: PluginRegistry) {
//        GeneratedPluginRegistrant.registerWith(registry)
//    }
}