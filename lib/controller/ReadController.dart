import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/db/DataBaseManager.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/utils/DialogUtil.dart';
import 'package:zzfiction/utils/MeasureStringUtil.dart';

class ReadController extends SuperController {
  bool isShowFloatButton() {
    FictionRepository fs = Get.find<FictionRepository>();
    //使用数据库里面的id去判断是不是本地的,有id就是本地
    if (fs.currentFictionSource.id != null) {
      return false;
    }
    return true;
  }

  @override
  void onReady() {
    getCurrentDirs();
  }
  //获取当前的目录列表
  List<FictionChapter> getCurrentDirs() {
    FictionRepository fs = Get.find<FictionRepository>();
    currentDir= fs.currentFictionSource.chapters;
    update();
  }
  List<FictionChapter> currentDir=[];

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  double padding = 17;
  //这个是单章的,最后试试就三章的大小,感觉实在不能放太多,测量就不对
  List<String> list = [];

  //分割计算content内容
  calculatePageNUms() async {
    FictionRepository fs = Get.find<FictionRepository>();
    List<String> listr22 = await MeasureStringUtil.calculatePageNUms(
        fs.currentFictionChapter.content);
    list.addAll(listr22);
    update();
  }

  //加载下一章//加载啥内容?
  loadNextChapter() async {
    DialogUtil.showLoading();
    FictionRepository fs = Get.find<FictionRepository>();
    fs.currentFictionSource.readdingChapter++;
    fs.currentFictionChapter = fs
        .currentFictionSource.chapters[fs.currentFictionSource.readdingChapter];
    if (fs.currentFictionChapter.content == null) {
      String singleChapterContent = await SearchEngine()
          .getSingleChapterContent(
              fs.currentFictionSource, fs.currentFictionSource.readdingChapter);

      fs.currentFictionChapter.content = singleChapterContent;
      await DataBaseManager().updateOneChapterContent(fs.currentFictionChapter);
    }

    List<String> listr22 = await MeasureStringUtil.calculatePageNUms(
        fs.currentFictionChapter.content);
    list.addAll(listr22);
    await DataBaseManager().updateOneFiction(fs.currentFictionSource);
    DialogUtil.dismissLoading();
    update();
  }

  loadPreChapter() {}
  //仅仅是显示用
  int pageIndex = 1;
  onPageViewChange(index) async {
    print("$index");
    pageIndex = index + 1;
    if (index + 1 == list.length) {
      await loadNextChapter();
    }
    update();
  }

  addOneBook() async {
    FictionRepository fs = Get.find<FictionRepository>();
    await DataBaseManager().insertOneFiction(fs.currentFictionSource);
    await fs.queryAllLocalBook();
    update();
    DialogUtil.showToast("添加成功");
  }
}
