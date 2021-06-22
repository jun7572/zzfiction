import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/db/DataBaseManager.dart';
import 'package:zzfiction/page/ReaddingBottomSheet.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/utils/AppSettingUtil.dart';
import 'package:zzfiction/utils/DialogUtil.dart';
import 'package:zzfiction/utils/MeasureStringUtil.dart';

class ReadController extends SuperController {
  GlobalKey<ScaffoldState> gk = GlobalKey<ScaffoldState>();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  /// 临时放这,现实功能先  0是light 1是dark
  bool mode = true;
  //PageController
  final PageController pc = PageController(initialPage: 0);

  Color backgrandColor_light = Color(0xFFCCE8CF);
  Color fontColor_light = Colors.black;

  Color backgrandColor_dark = Colors.black;
  Color fontColor_dark = Colors.white;

  double brightnessValue = 0;
  bool brightnessFollowSystem = false;
  var title=''.obs;
  var percent=''.obs;
  brightnessChange(i) async{
    brightnessFollowSystem = false;

    await ScreenBrightness.setScreenBrightness(i);
    brightnessValue = i;
    update(["BrightnessBottomSheet"]);
  }

  changeBrightFollow(b) async{
    brightnessFollowSystem = b;
    if (brightnessFollowSystem) {

      await ScreenBrightness.setScreenBrightness(-1);
    }

    update(["BrightnessBottomSheet"]);
  }

  Color getBackgrandColor() {
    return mode ? backgrandColor_light : backgrandColor_dark;
  }

  Color getFontColor() {
    return mode ? fontColor_light : fontColor_dark;
  }

  bool isShowFloatButton() {
    FictionRepository fs = Get.find<FictionRepository>();
    //使用数据库里面的id去判断是不是本地的,有id就是本地
    if (fs.currentFictionSource.id != null) {
      return false;
    }

    return true;
  }

  //如果使用了这个的话就不应该在stateful进行初始化,不利于代码管理
  @override
  void onReady() {}
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentDirs();
    initTheme();
    initPage();
  }


  initPage() async {
    await calculatePageNUms();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      FictionRepository fss = Get.find<FictionRepository>();

      pc.jumpToPage(fss.currentFictionSource.pageNum ?? 0);
    });
  }

  initTheme() async {
    var b = await AppSettingUtil.getReadTheme();
    var i = await AppSettingUtil.getBrightnessColor();
    backgrandColor_light = Color(i);
    mode = b ?? true;
    if(mode){
      setLightMode();
    }else{
      setDarkMode();
    }

    update();
  }

  //获取当前的目录列表
  List<FictionChapter> getCurrentDirs() {
    FictionRepository fs = Get.find<FictionRepository>();
    currentDir = fs.currentFictionSource.chapters;
    update();
  }

  int fictionChapterDirIndex() {
    FictionRepository fs = Get.find<FictionRepository>();
    return fs.currentFictionSource.readdingChapter;
  }

  FictionChapter getCurrentChapter() {
    FictionRepository fs = Get.find<FictionRepository>();
    return fs.currentFictionChapter;
  }

  //刷新当前小说的章节,看是否有更新
  refreshFiction() async {
    DialogUtil.showLoading();

    FictionRepository fs = Get.find<FictionRepository>();
    FictionSource openSourceToGetDirs =
        await SearchEngine().openSourceToGetDirs(fs.currentFictionSource);
    var list = await DataBaseManager().updateFiction(openSourceToGetDirs);

    if (list != null) {
      await fs.queryAllLocalBook();
      currentDir = fs.currentFictionSource.chapters;
      DialogUtil.showToast("更新了${list.length}章");
      update();
    } else {
      DialogUtil.showToast("没得更新");
    }

    DialogUtil.dismissLoading();
  }

  int index11 = 0;
  //屏幕居中点击事件
  centerlickEvent(TapDownDetails e) async {
    int length = 80;
    double left = Get.width / 2 - length;
    double right = Get.width / 2 + length;
    double top = Get.height / 2 - length;
    double bottom = Get.height / 2 + length;
    if ((e.globalPosition.dx > left && e.globalPosition.dx < right) &&
        (e.globalPosition.dy < bottom && e.globalPosition.dy > top)) {
      // gk.currentState.openDrawer();
      Get.bottomSheet(ReaddingBottomSheet(), barrierColor: Colors.transparent);
      return;
    }

    if (e.globalPosition.dx > (Get.width / 2)) {
      await pc.animateToPage(pc.page.round() + 1,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    }
  }

  dirClick(int index) async {
    // int tempReadding =fs.currentFictionSource.readdingChapter;

    FictionRepository fs = Get.find<FictionRepository>();
    fs.currentFictionChapter = fs.currentFictionSource.chapters[index];
    fs.currentFictionSource.readdingChapter = index;
    list.clear();
    try {
      await calculatePageNUms();
    } catch (e) {
      DialogUtil.showToast("无数据");
      Get.back();
      return;
    }

    update();
    Get.back();
  }

  //点击了修改行高之类的之后要重新计算高度
  reloadText() async {
    DialogUtil.showLoading();
    list.clear();
    await calculatePageNUms();
    DialogUtil.dismissLoading();
    update();
  }

  List<FictionChapter> currentDir = [];

  FictionChapter currentChapter;
  @override
  void onDetached() {
    setDarkMode();

  }

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  double padding = 17;

  //这个是总共的,单章的数据我看看啊
  List<FictionChapterStr> list = [];

  //分割计算content内容
  calculatePageNUms() async {
    FictionRepository fs = Get.find<FictionRepository>();
    List<String> listr22 = [];

    if (fs.currentFictionChapter.content == null) {
      await loadChapter(index: fs.currentFictionSource.readdingChapter);
    } else {
      listr22 = await MeasureStringUtil.calculatePageNUms(
          fs.currentFictionChapter.content);
    }

    // fs.currentFictionChapter.listStr=listr22;
    // listPagenum.add(fs.currentFictionChapter.listStr.length);
    for (int i = 0; i < listr22.length; i++) {
      list.add(FictionChapterStr(i, listr22[i], fs.currentFictionChapter.id,
          fs.currentFictionChapter.title, listr22.length));
    }

    update();
  }

  //加载下一章//加载啥内容?
  // 没参数就下一章,有参数就加载参数的那章
  loadChapter({int index}) async {
    DialogUtil.showLoading();
    FictionRepository fs = Get.find<FictionRepository>();

    if (index == null) {
      fs.currentFictionSource.readdingChapter++;
    } else {
      fs.currentFictionSource.readdingChapter = index;
    }
    //本地的目录看完了
    if (fs.currentFictionSource.readdingChapter >
        fs.currentFictionSource.chapters.length - 1) {
      fs.currentFictionSource.readdingChapter++;
      DialogUtil.showToast("本地目录已看完");
      DialogUtil.dismissLoading();
      return;
    }
    fs.currentFictionChapter = fs
        .currentFictionSource.chapters[fs.currentFictionSource.readdingChapter];

    if (fs.currentFictionChapter.content == null ||
        fs.currentFictionChapter.content.isEmpty ||
        SearchEngine.noData == fs.currentFictionChapter.content) {
      String singleChapterContent = await SearchEngine()
          .getSingleChapterContent(
              fs.currentFictionSource, fs.currentFictionSource.readdingChapter);

      fs.currentFictionChapter.content = singleChapterContent;
      await DataBaseManager().updateOneChapterContent(fs.currentFictionChapter);
    }

    List<String> listr22 = await MeasureStringUtil.calculatePageNUms(
        fs.currentFictionChapter.content);
    // fs.currentFictionChapter.listStr=listr22;

    // list.addAll( fs.currentFictionChapter.listStr);
    for (int i = 0; i < listr22.length; i++) {
      list.add(FictionChapterStr(i, listr22[i], fs.currentFictionChapter.id,
          fs.currentFictionChapter.title, listr22.length));
    }

    //更新小说当前章节
    await DataBaseManager().updateOneFiction(fs.currentFictionSource);
    DialogUtil.dismissLoading();

    update();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await pc.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.linear);
      FictionRepository fss = Get.find<FictionRepository>();
      fss.currentFictionSource.pageNum = 0;
      await DataBaseManager().updateOneFiction(fss.currentFictionSource);
    });
  }

  loadPreChapter() {}

  onPageViewChange(page) async {
    FictionRepository fss = Get.find<FictionRepository>();
    fss.currentFictionSource.pageNum = page;
    await DataBaseManager().updateOneFiction(fss.currentFictionSource);
  }

  //但是怎么知道滑到了前面的章节
  bool lastPageLoadMore(UserScrollNotification notification) {
    FictionRepository fs = Get.find<FictionRepository>();

    if ((notification.direction == ScrollDirection.reverse) &&
        (pc.page.ceil() + 1 == list.length)) {
      print('加载下一章');
      try {
        loadChapter();
      } catch (e) {}
    }
    if ((notification.direction == ScrollDirection.forward &&
        pc.page.ceil() == 0)) {
      print("加载前一章");
    }
    return true;
  }

  addOneBook() async {
    FictionRepository fs = Get.find<FictionRepository>();
    fs.currentFictionSource.lastUseTime = DateTime.now().millisecondsSinceEpoch;
    await DataBaseManager().insertOneFiction(fs.currentFictionSource);
    await fs.queryAllLocalBook();
    update();
    DialogUtil.showToast("添加成功");
  }

  bottomSheetClick() {
    mode = !mode;
    if(mode){
      setLightMode();
    }else{
      setDarkMode();
    }
    AppSettingUtil.setReadTheme(mode);
    update();
  }

  setDarkMode(){
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light);

    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  setLightMode(){
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark);

    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
