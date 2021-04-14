import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

import 'FictionSourceController.dart';
//这个放历史记录啊啥的
class SearchController extends GetxController{
 String _search="";
 onSearchChange(String s){
  _search=s;
  print(s);
 }
 //按钮点击事件
 searchContent()async{
    NativeProgressHud.showWaiting();
    //todo 记得过滤成功失败的情形
    FictionRepository find = Get.find<FictionRepository>();
    find.fss=await SearchEngine().search360(_search);
    NativeProgressHud.hideWaiting();
    Get.toNamed(PageName.SearchDatapage);

 }
@override
  void onReady() {


  }
  @override
  void onInit() {

    super.onInit();

  }

}