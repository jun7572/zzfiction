

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/controller/SearchController.dart';
import 'package:zzfiction/managers/screen_manager.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/utils/DialogUtil.dart';

import '../SearchEngine.dart';
  //搜索回来的所有数据源
class SearchDatapage extends GetView<SearchController>{
  // FictionRepository fs= Get.find<FictionRepository>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.white,title: Text("搜索结果"),),
      body: GetBuilder<SearchController>(
        init: controller,
       dispose: (s){
         controller.fss.clear();
       },
       builder: (controller){
         return  SmartRefresher(
           physics: BouncingScrollPhysics(),
           controller: controller.refreshController,
           enablePullDown: false,
           enablePullUp: true,
            // footer: SliverToBoxAdapter(child: Container(height:50,color: Colors.red,child: Text("asdfasfdaf"),)),
            footer: CustomFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              builder: (BuildContext context,LoadStatus mode){
                Widget body ;
                if(mode==LoadStatus.idle){
                  body =  Text("pull up load");
                }
                else if(mode==LoadStatus.loading){
                  body =  CupertinoActivityIndicator();
                }
                else if(mode == LoadStatus.failed){
                  body = Text("Load Failed!Click retry!");
                }
                else if(mode == LoadStatus.canLoading){
                  body = Text("release to load more");
                }
                else{
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child:body),
                );
              },
            ),
           onLoading: controller.loadmore,

           child: ListView.builder(

               itemCount: controller.fss.length,
               itemBuilder:  (_,index){
                 return GestureDetector(

                   child: Container(
                     color: Colors.white,
                     margin: EdgeInsets.symmetric(horizontal: getWp(35),vertical: getHp(3)),

                     padding: EdgeInsets.all(getHp(27)),child: Row(

                     children: [

                       Text( "源${index} : ",style: TextStyle(fontSize: getSp(12)),),

                       Text( controller.fss[index].title,style: TextStyle(fontSize: getSp(12)),),

                       // Text( controller.fss[index].path),
                     ],
                   ),),onTap: ()async{
                   DialogUtil.showLoading();
                   await controller.getFictionDirs(index);
                   DialogUtil.dismissLoading();
                 },);
               }),

         );
       },
      ),
    );
  }

}