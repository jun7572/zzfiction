import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/gen_a/A.dart';
import 'package:zzfiction/managers/screen_manager.dart';
import 'package:zzfiction/utils/AppSettingUtil.dart';
import 'package:zzfiction/base/DialogUtil.dart';
import 'package:zzfiction/utils/MeasureStringUtil.dart';

class SetReaddingOptionPage extends GetView<ReadController> {
  final  String _stringss =
      "  汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n      汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪"
      "  汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n      汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪"
      "  汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n      汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪"
      "  汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n      汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪"
      "  汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n      汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪"
      "  汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪.\n\n      汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪,汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪汪";
  double height =MeasureStringUtil.height;
  double size =MeasureStringUtil.size;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReadController>(
      initState: (State state){

      },
        init: controller,
        builder: (ctr) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                      child: SingleChildScrollView(
                        child:  Container(
                          width: Get.width,
                          color: Color(0xFFCCE8CF),
                          padding: EdgeInsets.all(17),
                          child:Text(_stringss,
                              style: TextStyle(
                                color: Colors.black,
                                height:height,
                                fontStyle: FontStyle.normal,
                                fontSize: size,
                              )
                          ),
                        ),

                      )),
                  Container(height: 100,
                    width: Get.width,
                    color: Colors.black,
                  child: Row(
                    children: [
                      //todo
                      _settingButton((){
                        // MeasureStringUtil.setTextSize(size++, height);
                        AppSettingUtil.setFontSize(size++);
                         ctr.update();
                     }, A.assets_fontszeadd),
                      _settingButton((){
                        // MeasureStringUtil.setTextSize(size--, height);
                        AppSettingUtil.setFontSize(size--);
                        ctr.update();
                      }, A.assets_fontsizeminus),
                      _settingButton((){
                        // MeasureStringUtil.setTextSize(size, height+=0.1);
                        AppSettingUtil.setLineHeight(height+=0.1);
                        ctr.update();
                      }, A.assets_lineheightminus),
                      _settingButton((){
                        // MeasureStringUtil.setTextSize(size, height-=0.1);
                        AppSettingUtil.setLineHeight(height-=0.1);
                        ctr.update();
                      }, A.assets_lineheightadd),



                    ],
                  ),),

                ],
              ),
            ),
          );
        });
  }
}
Widget _settingButton(Function f,String s){
  return  Expanded(
    flex: 1,
    child: ElevatedButton(onPressed:f,

      style: ElevatedButton.styleFrom(shape:CircleBorder(),primary: Colors.black),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(s,width: getWp(44),height: getWp(44),),
      ),
    ),
  );
}
