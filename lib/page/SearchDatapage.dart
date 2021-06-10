

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/controller/SearchController.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/utils/DialogUtil.dart';

import '../SearchEngine.dart';
  //搜索回来的所有数据源
class SearchDatapage extends GetView<SearchController>{
  // FictionRepository fs= Get.find<FictionRepository>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(),
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
                 return TextButton(

                   child: Card(
                     child: Padding(padding: EdgeInsets.all(10),child: Column(
                       children: [
                         Text( controller.fss[index].title),

                         Text( controller.fss[index].path),
                       ],
                     ),),
                   ),onPressed: ()async{
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