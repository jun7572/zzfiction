import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/db/DataBaseManager.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/base/DialogUtil.dart';

class BookRepositoryController extends SuperController {

  // final BannerAd myBanner = BannerAd(
  //   // 我的id
  //   adUnitId: 'ca-app-pub-7482911524392337/8241020046',
  //   // 测试id
  //   // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
  //   size: AdSize.banner,
  //   request: AdRequest(),
  //   listener: BannerAdListener(),
  // );
  //查询所有本地书籍
  getLocalBooks() async {
    var find = Get.find<FictionRepository>();
    await find.queryAllLocalBook();
    update();
  }
  openLocalBook(int index) async {
    DialogUtil.showLoading();
    var find = Get.find<FictionRepository>();
    await find.openLocalBook(index);

    DialogUtil.dismissLoading();
    Get.toNamed(AppPage.ReadPage);
  }
  deleteOneBook(int index)async{
    DialogUtil.showLoading();
    var find = Get.find<FictionRepository>();
    await find.deleteOneLocalBook(index);
    DialogUtil.dismissLoading();
    update();
  }
  @override
  void onReady() {
    print("onReady");
    super.onReady();
    getLocalBooks();
    // myBanner.load();
  }
  @override
  void onDetached() {
    // TODO: implement onDetached
    print("onDetached");
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
    print("onInactive");

  }

  @override
  void onPaused() {
    // TODO: implement onPaused
    print("onPaused");
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
    print("onResumed");
  }


}