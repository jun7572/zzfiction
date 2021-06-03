import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/utils/DialogUtil.dart';
import 'package:zzfiction/utils/MeasureStringUtil.dart';

class SetReaddingOptionPage extends GetView<ReadController> {
  final  String _stringss =
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
                          color: Colors.black,
                          padding: EdgeInsets.all(17),
                          child:Text(_stringss,
                              style: TextStyle(
                                color: Colors.white,
                                height:height,
                                fontStyle: FontStyle.normal,
                                fontSize: size,
                              )
                          ),
                        ),

                      )),
                  Container(height: 200,

                  child: Wrap(
                    children: [
                      
                      _settingButton((){
                        MeasureStringUtil.setTextSize(size++, height);
                       ctr.update();
                     }, "Aa+"),
                      _settingButton((){
                        MeasureStringUtil.setTextSize(size--, height);
                        ctr.update();
                      }, "Aa-"),
                      _settingButton((){
                        MeasureStringUtil.setTextSize(size, height+=0.1);
                        ctr.update();
                      }, "行高+"),
                      _settingButton((){
                        MeasureStringUtil.setTextSize(size, height-=0.1);
                        ctr.update();
                      }, "行高-"),
                      _settingButton((){
                            DialogUtil.showColorDialog();
                      },'背景颜色'),

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
  return  ElevatedButton(onPressed:f,
    style: ElevatedButton.styleFrom(shape:CircleBorder(),primary: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(s,style: TextStyle(color: Colors.black),),
    ),
  );
}
