import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/utils/AppSettingUtil.dart';
///亮度设置的BottomSheet
class BrightnessBottomSheet extends GetView<ReadController>{
  @override
  Widget build(BuildContext context) {
 return GetBuilder(
    id: "BrightnessBottomSheet",
     init:controller,
     builder: (ReadController controller){
   
      return Container(
        height: 200,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container (
              color: Colors.black,

              child: Column(
              children: [

                Row(children: [
                  Expanded(
                    flex: 1,
                    child: Slider(
                        min: 0,
                        max: 1,
                        value: controller.brightnessValue, onChanged:controller.brightnessChange ),
                  ),
                  // ElevatedButton(onPressed:controller.changeBrightFollow,
                  // child: Text("跟随系统"),
                  //    style:controller.brightnessFollowSystem? ElevatedButton.styleFrom(shape:StadiumBorder(),primary: Colors.blue ):
                  //     ElevatedButton.styleFrom(side: BorderSide(width: 1,color: Colors.white),shape:StadiumBorder(),primary: Colors.transparent),
                  //
                  //
                  // ),
                  Switch(

                    value: controller.brightnessFollowSystem, onChanged: controller.changeBrightFollow,
                    inactiveTrackColor: Colors.grey,),
                  Text("跟随系统",style: TextStyle(color:  controller.brightnessFollowSystem?Colors.blue:Colors.white),),
                ],),
                SizedBox(height: 10,),


                Row(
                  children: [
                    colorButton(c:Color(0xffEEEEEE),color: 0xffEEEEEE ),
                    colorButton(c:Color(0xffDCEDDB), color: 0xffDCEDDB),
                    colorButton(c:Color(0xffE1D3CA), color: 0xffE1D3CA),
                    colorButton(c:Color(0xffF2EADF), color: 0xffF2EADF),
                    colorButton(c:Color(0xffF8E5E9), color: 0xffF8E5E9),
                    colorButton(c:Color(0xFFCCE8CF), color: 0xFFCCE8CF),
                  ],
                ),
                SizedBox(height: 10,),

              ],
            ),),
          ],
        ),
      );
 });
  }
   Widget colorButton({Color c,int color}){
    return  ElevatedButton(onPressed: (){
      AppSettingUtil.setBrightnessColor(color);
      controller.backgrandColor_light=Color(color);
      controller.update();
      }, child: Container(width: 30,height: 30,),style: ElevatedButton.styleFrom(shape: CircleBorder(),primary: c,));
    }
}