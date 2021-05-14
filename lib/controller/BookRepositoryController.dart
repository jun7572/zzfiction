import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/utils/DialogUtil.dart';

class BookRepositoryController extends SuperController {
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
    Get.toNamed(PageName.ReadPage);
  }
  @override
  void onReady() {
    print("onReady");
    super.onReady();
    getLocalBooks();
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