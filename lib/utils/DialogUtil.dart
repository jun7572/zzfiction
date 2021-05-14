import 'package:flutter/material.dart';
import 'package:flutter_native_alert/flutter_native_alert.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:zzfiction/theme/ThemeUtil.dart';

class DialogUtil{
  static showLoading(){
    NativeProgressHud.showWaiting(backgroundColor: "#29B6F6");

  }
  static dismissLoading(){
    NativeProgressHud.hideWaiting();
  }
  static showToast(String s){
    /// Pass in the string to be displayed, the default display time is 1.5 seconds
    FlutterNativeAlert.getInstance().showToast(s, duration: Duration(milliseconds: 1500));
  }
}