import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

class FictionSourceController extends SuperController<FictionSource>
    with SingleGetTickerProviderMixin {
  TextEditingController textEditingController = TextEditingController();
  final List<Tab> myTabs = [
    Tab(
      iconMargin: EdgeInsets.all(0),
      text: "搜索",
      icon: new Icon(Icons.search_rounded),
    ),
    Tab(
      iconMargin: EdgeInsets.all(0),
      text: "我的书库",
      icon: new Icon(Icons.list_alt_rounded),
    ),
  ];
  String _search = "";
  onSearchChange(String s) {
    _search = s;
    print(s);
  }

  toSearchPgae() {
    Get.toNamed(AppPage.Searchpage);
  }

  TabController tc;
  //初始化第一次的资源
  @override
  void onInit() {
    tc = TabController(initialIndex: 0, length: myTabs.length, vsync: this);

    super.onInit();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    tc.dispose();
  }
}
