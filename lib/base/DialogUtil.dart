import 'package:alert/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:zzfiction/theme/ThemeUtil.dart';

class DialogUtil{
  static bool show=false;
  static showLoading(){
    show=true;
    NativeProgressHud.showWaiting(backgroundColor: "#29B6F6");
    Future.delayed(Duration(seconds: 15),(){
      if(show){
        showToast("失败,请重试");
        dismissLoading();
      }
    });
  }
  static dismissLoading(){
    show=false;
    NativeProgressHud.hideWaiting();
  }
  static showToast(String s){


    Alert(message: s).show();
  }
  static showColorDialog(){
    Color pickerColor=Colors.black;
    Color changeColor=Colors.white;


// raise the [showDialog] widget
    showDialog(
      context: Get.context, builder:(_){
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (c){

              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   showLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
            //
            // child: MultipleChoiceBlockPicker(
            //   pickerColors: currentColors,
            //   onColorsChanged: changeColors,
            // ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                  Get.back();

              },
            ),
          ],
        );
    }
    );
  }
}