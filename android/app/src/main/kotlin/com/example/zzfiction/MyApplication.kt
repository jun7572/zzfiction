package com.june.fiction

import android.content.Context
import androidx.multidex.MultiDex
import com.zh.pocket.PocketSdk
import com.zh.pocket.common.config.ADConfig
import io.flutter.app.FlutterApplication


//import io.flutter.plugins.GeneratedPluginRegistrant

class MyApplication : FlutterApplication() {
    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(this)


    }

    override fun onCreate() {
        super.onCreate()

        PocketSdk.initSDK(applicationContext, "xiaomi", "1")
    }

//    override fun registerWith(registry: PluginRegistry) {
//        GeneratedPluginRegistrant.registerWith(registry)
//    }
}