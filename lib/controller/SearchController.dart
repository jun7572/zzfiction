import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/controller/TestController.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/utils/AppSettingUtil.dart';
import 'package:zzfiction/utils/DialogUtil.dart';

import 'FictionSourceController.dart';
//这个放历史记录啊啥的
class SearchController extends GetxController{

 int page=1;
 RefreshController refreshController = RefreshController(initialRefresh: false, initialLoadStatus:LoadStatus.loading );
 TextEditingController textEditingController=TextEditingController();
 //从网络查询回来的当次的
 List<FictionSource> fss=[];


 //按钮点击事件
 searchContent()async{
   if(textEditingController.text.isEmpty){
     DialogUtil.showToast("输入内容啊");
     return;
   }
    DialogUtil.showLoading();
    //todo 记得过滤成功失败的情形
    searchHistory.insert(0, textEditingController.text);
    await AppSettingUtil.setSearchHistory(searchHistory);
    // FictionRepository find = Get.find<FictionRepository>();
    List<FictionSource> search360loadmore =[];

    try{
      search360loadmore=await SearchEngine().search360(textEditingController.text);
    }catch(e){
      DialogUtil.dismissLoading();

      DialogUtil.showToast("如果没结果,请切换流量或者wifi,请不要频繁搜索一样的内容");

    }
    fss.addAll(search360loadmore);
    DialogUtil.dismissLoading();
    Get.toNamed(AppPage.SearchDatapage);
    update();
 }
 List<Widget> getHis(){
   List<Widget> lllss=[];
   for(String s in searchHistory){
     lllss.add(GestureDetector(
       onTap: (){
         textEditingController.text=s;

       },
       child: Container(
         margin:EdgeInsets.all(8) ,
         color: Colors.black54,
         padding: EdgeInsets.all(8),
         child: Text(s,style: TextStyle(color: Colors.white),),
       ),
     )
     );
   }
   return lllss;
 }
 List<String> searchHistory=[];
@override
  void onReady() {

  init();
  Get.lazyPut(() => TestController());
  }
  init()async{
    searchHistory =await AppSettingUtil.getSearchHistory()??[];
    update();
  }

  loadmore()async{
    page++;
    List<FictionSource> search360loadmore = await SearchEngine().search360Loadmore(textEditingController.text,page);
    fss.addAll(search360loadmore);
    refreshController.loadComplete();
    update();

 }

 getFictionDirs(int index)async{

   FictionRepository find = Get.find<FictionRepository>();

   find.currentFictionSource=fss[index];
   try{
     await updateFictionSourceList(find.currentFictionSource);
   }catch( e){
     DialogUtil.showToast("该源失效");
   }

   Get.toNamed(AppPage.FictionDirpage);
 }
 Future<FictionSource> updateFictionSourceList(FictionSource fs)async{
   FictionSource ffss=await SearchEngine().openSourceToGetDirs(fs);
   return ffss;
 }
  @override
  void onInit() {

    super.onInit();

  }

}