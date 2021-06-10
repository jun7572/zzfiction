import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/db/DataBaseManager.dart';
import 'package:zzfiction/page/DirDrawer.dart';
import 'package:zzfiction/page/ReaddingBottomSheet.dart';

import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/utils/MeasureStringUtil.dart';
import 'package:zzfiction/utils/PreloadManager.dart';

class ReadWidget2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReadWidgetState2();
  }
}

//扔一个String  处理成List<String>
class ReadWidgetState2 extends State<ReadWidget2> {

  ReadController controller = Get.find<ReadController>();


  @override
  void dispose() {
    super.dispose();

    controller.list.clear();

  }
  int iii=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: controller.gk,
      // bottomSheet: ReaddingBottomSheet(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: controller.isShowFloatButton()
          ? FloatingActionButton(
              onPressed: () {
                controller.addOneBook();

              },
              backgroundColor: Theme.of(context).primaryColor,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "添加本地书库",
                    style: TextStyle(color: Colors.black,fontSize: 10),
                  ),
                ),
              ),
            )
          : null,
      drawer: DirDrawer(),


      body: GetBuilder<ReadController>(
        init: controller,
        builder: (ctr) {

          return Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                // color: Color(0xFFCCE8CF),
                color: ctr.getBackgrandColor(),
              ),
              SafeArea(

                bottom:false,
                child:  NotificationListener(
                  onNotification:ctr.lastPageLoadMore,
                  child: GestureDetector(
                    onTapDown: ctr.centerlickEvent,
                    // onTapDown: (t){
                    //   showBottomSheet(backgroundColor: Colors.red,context: context, builder: (_){
                    //     return ReaddingBottomSheet();
                    //   });
                    // },
                    child: PageView.builder(

                        controller: ctr.pc,
                        onPageChanged: ctr.onPageViewChange,
                        itemCount: ctr.list.length,
                        itemBuilder: (_, index) {

                          return  Container(

                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: ctr.padding),
                            height: Get.height,
                            width: Get.width,
                            child: Column(
                              children: [
                                Container(
                                  height: 20,
                                  // color: Colors.blue,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex:1,
                                          child: Text(ctr.list[index].title,overflow: TextOverflow.ellipsis,style: TextStyle(color: ctr.getFontColor(),),)),

                                      // Text('${(ctr.getCurrentChapter().index+1).ceil().toInt()} / ${ctr.getCurrentChapter().listStr.length}'),
                                      Text('${ctr.list[index].index+1} / ${ctr.list[index].totalSize}',style: TextStyle(color:ctr.getFontColor(),)),
                                    ],
                                  ),
                                ),
                                Container(

                                  // decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
                                  height: MeasureStringUtil.windowsHeight-20,
                                  //小说 content
                                  child: Text(

                                    ctr.list[index].content,
                                    style: TextStyle(
                                      color: ctr.getFontColor(),
                                      height:MeasureStringUtil.height,
                                      fontStyle: FontStyle.normal,
                                      fontSize: MeasureStringUtil.size,
                                    ),


                                  ),
                                  // clipBehavior: Clip.hardEdge,
                                ),




                              ],
                            ),

                          );
                        }),
                  ),
                ),
              ),

              // TextButton(onPressed: (){
              //
              //   PreloadManager().rp.sendPort.send("sfasfasfda");
              //
              // }, child: Text("asdfasfafda")),

            ],
          );
        },
      ),
    );
  }
}
