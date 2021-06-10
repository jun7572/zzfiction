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
            width: getWp(290),
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(31.5, 24.5, 31.5, 47) ,
            // decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: 0.5,color: Colors.white,)),color: Colors.black ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fr.currentFictionSource.title,style: TextStyle(color: Colors.white,fontSize: getSp(18)),),
                SizedBox(height: getHp(38.5),),
                Expanded(
                  flex: 1,
                  child: ScrollablePositionedList.builder(

                    itemCount: ctr.currentDir.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        ctr.dirClick(index);
                      },
                      child: Container(

                          height: getHp(43),
                        alignment: AlignmentDirectional(-1,0),
                        decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: 0.5,color: Color(0xff666666),)),color: Colors.black ),
                        child: Text(
                          ctr.currentDir[index].title,
                          maxLines: 1,
                          style: TextStyle(


                              fontSize: getSp(12),

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
                ),
              ],
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
