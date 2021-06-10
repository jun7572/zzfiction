import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/controller/ReadController.dart';

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
                    colorButton(c:Color(0xffEEEEEE),f: (){} ),
                    colorButton(c:Color(0xffDCEDDB),f: (){} ),
                    colorButton(c:Color(0xffE1D3CA),f: (){} ),
                    colorButton(c:Color(0xffF2EADF),f: (){} ),
                    colorButton(c:Color(0xffF8E5E9),f: (){} ),
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
   Widget colorButton({Function f,Color c}){
    return  ElevatedButton(onPressed: f, child: Container(width: 30,height: 30,),style: ElevatedButton.styleFrom(shape: CircleBorder(),primary: c,));
    }
}