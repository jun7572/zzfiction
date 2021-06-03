import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/managers/screen_manager.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

class DirDrawer extends GetView<ReadController> {
  FictionRepository fr = Get.find<FictionRepository>();
  @override
  Widget build(BuildContext context) {

    return GetBuilder<ReadController>(
        init: controller,

       initState: (i){
         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
           FictionRepository fr = Get.find<FictionRepository>();
           ReadController readController = Get.find<ReadController>();
           readController.itemScrollController.jumpTo(index: fr.currentFictionSource.readdingChapter);
         });
       },

        builder: (ctr) {

          return Container(
            width: Get.width-150,
            color: Colors.black,
            // decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: 0.5,color: Colors.white,)),color: Colors.black ),
            child:  ScrollablePositionedList.builder(

              itemCount: ctr.currentDir.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){
                  ctr.dirClick(index);
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: 0.5,color: Colors.white,)),color: Colors.black ),
                  child: Text(
                    ctr.currentDir[index].title,

                    style: TextStyle(

                      height: 2,
                        fontSize: 15,
                        color: fr.currentFictionSource
                            .readdingChapter ==
                            index
                            ? Colors.blue
                            : Colors.white),
                  ),
                ),
              ),
              itemScrollController: ctr.itemScrollController,
              itemPositionsListener: ctr.itemPositionsListener,
            ),

            // child: ListView.builder(
            //     itemCount: ctr.currentDir.length,
            //     itemBuilder: (_,index){
            //   return  Text(
            //     ctr.currentDir[index].title,
            //     style: TextStyle(
            //         color: fr.currentFictionSource
            //             .readdingChapter ==
            //             index
            //             ? Colors.blue
            //             : Colors.white),
            //   );
            // }),
          );
        });
  }
}
