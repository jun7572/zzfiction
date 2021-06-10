import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen/screen.dart';
import 'package:zzfiction/approute/AppRoutes.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/utils/AppSettingUtil.dart';

import 'BrightnessBottomSheet.dart';

class ReaddingBottomSheet extends StatelessWidget {
  // double ii = 10;
  String title='';
  String percent='';
  @override
  Widget build(BuildContext context) {

    return GetBuilder<ReadController>(
      initState: (State state){

        FictionRepository fictionRepository= Get.find<FictionRepository>();
        title= fictionRepository.currentFictionSource.title;
        percent='${fictionRepository.currentFictionSource.readdingChapter}/${fictionRepository.currentFictionSource.chapters.length}';
      },
      init: Get.find<ReadController>(),
      builder: (ctr) {

        return Container(
          height: 200,

          child: Column(

            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: ctr.bottomSheetClick,
                    style: ElevatedButton.styleFrom(primary: !ctr.mode?Colors.white:Colors.blue,shape:CircleBorder(),onSurface:  Colors.blue ),
                    child:   Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: !ctr.mode?Icon(Icons.wb_sunny,color: Colors.amberAccent,size: 35,):Icon(Icons.nightlight_round,color: Colors.white,size: 35,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Container(
                color: Colors.black54,

                child: Column(
                  children: [
                    Row(children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(title,
                          style: TextStyle(color: Colors.white),),
                      ),
                      Spacer(),
                      Text(percent, style: TextStyle(color: Colors.white),),
                      Spacer(),
                    ],),

                    Row(
                      children: [

                        bottomButton(f:() async {
                          ctr.refreshFiction();
                        },icon: Icons.refresh_rounded,title: "刷新"),


                        bottomButton(f:() async {
                          ctr.gk.currentState.openDrawer();
                          Get.back();
                        },icon: Icons.list_rounded,title: "目录"),



                        bottomButton(f:() async {
                          Get.back();
                           Get.toNamed(AppPage.SetReaddingOptionPage).then((v)async{
                             print("asdfasfasf");
                           await  AppSettingUtil.initReaddingSetting();
                             ctr.reloadText();
                           });
                          //  await  AppSettingUtil.initReaddingSetting();
                          // ctr.reloadText();
                        },icon: Icons.settings,title: "设置"),



                        bottomButton(f:() async {

                          Get.bottomSheet(BrightnessBottomSheet(),barrierColor: Colors.transparent);
                        },icon: Icons.brightness_5,title:"亮度"),
                      ],
                    ),



                  ],
                ),
              ),
              // Container(height: 10,,),


            ],
          ),
        );
      },
    );
  }
}
Widget bottomButton({Function f,IconData icon,String title}){
  return Expanded(
      flex: 1,
      child: TextButton(
        onPressed: f,
        child: Column(
          children: [
            Icon(icon,size: 30,color: Colors.white,),

            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ));
}
