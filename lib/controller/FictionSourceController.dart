import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/bean/FictionSource.dart';

class FictionSourceController extends SuperController<FictionSource>{
  TextEditingController textEditingController=TextEditingController();

  String _search="";
  onSearchChange(String s){
    _search=s;
    print(s);

  }
  toSearchPgae(){
    Get.toNamed(PageName.Searchpage);
  }
  //初始化第一次的资源
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onDetached() {

  }

  @override
  void onInactive() {

  }

  @override
  void onPaused() {

  }

  @override
  void onResumed() {

  }

}