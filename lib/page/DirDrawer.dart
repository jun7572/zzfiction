import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/managers/screen_manager.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

class DirDrawer extends GetView<ReadController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReadController>(
        init: Get.find<ReadController>(),
        builder: (ctr) {
          FictionRepository fr = Get.find<FictionRepository>();
          return Container(
            width: getWp(600),
            color: Color(0xAA000000),
            child: ListView.builder(
                itemCount: ctr.currentDir.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      TextButton(
                        onPressed: (){
                          //todo 点击目录
                        },
                          child: Text(
                        ctr.currentDir[index].title,
                        style: TextStyle(
                            color:
                                fr.currentFictionSource.readdingChapter == index
                                    ? Colors.blue
                                    : Colors.white),
                      )),
                      Divider(
                        color: Colors.white,
                        height: 1,
                      ),
                    ],
                  );
                }),
          );
        });
  }
}
