import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/db/DataBaseManager.dart';
import 'package:zzfiction/page/DirDrawer.dart';

import 'package:zzfiction/repository/FictionRepository.dart';

class ReadWidget2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReadWidgetState2();
  }
}

//扔一个String  处理成List<String>
class ReadWidgetState2 extends State<ReadWidget2> {
  PageController pc = PageController();
  ReadController controller = Get.find<ReadController>();
  @override
  void initState() {
    controller.calculatePageNUms();
    if (Platform.isAndroid) {
      // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      //
      // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

      // SystemChrome.restoreSystemUIOverlays();

    }
  }

  @override
  void dispose() {
    super.dispose();

    controller.list.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: controller.isShowFloatButton()
          ? FloatingActionButton(
              onPressed: () {
                controller.addOneBook();
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                "添加",
                style: TextStyle(color: Colors.black),
              ),
            )
          : null,
      drawer: DirDrawer(),
      body: GetBuilder<ReadController>(
        init: Get.find<ReadController>(),
        builder: (ctr) {
          return Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                color: Color(0xFFCCE8CF),
              ),
              SafeArea(
                child: PageView.builder(
                    controller: pc,
                    onPageChanged: ctr.onPageViewChange,
                    itemCount: ctr.list.length,
                    itemBuilder: (_, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: ctr.padding),
                        height: Get.height,
                        width: Get.width,
                        child: Text(
                          ctr.list[index],
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }),
              ),

              // Column(
              //   children: [
              //     SizedBox(height: 100,),
              //     ElevatedButton(
              //         child: Text("添加书籍"),
              //         onPressed: ()async{
              //           FictionRepository fs=Get.find<FictionRepository>();
              //           await DataBaseManager().insertOneFiction(fs.currentFictionSource);
              //           await fs.queryAllLocalBook();
              //           ctr.update();
              //           print("ok");
              //         }),
              //     ElevatedButton(
              //         child: Text("查看书籍"),
              //         onPressed: ()async{
              //           List<Map<String,dynamic>> list= await  DataBaseManager().queryAllLocalFiction();
              //
              //           for(Map mm in list){
              //             print(mm.toString());
              //           }
              //         }),
              //     Text('${ctr.pageIndex} / ${ctr.list.length}'),
              //   ],
              //
              // ),
            ],
          );
        },
      ),
    );
  }
}
