import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zzfiction/base/request.dart';
import 'package:zzfiction/bean/recommend_entity.dart';
import 'package:zzfiction/http/httpcontroller.dart';
import 'package:zzfiction/utils/ADManager.dart';

class ZuiShuController extends SuperController{
  List<RecommendRankingBooks> listbook=[];
  // AdSize siaze;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  initData();

  }


  initData()async{
    listbook.clear();
    List<RecommendEntity> list = await HttpController.getZuiShuRecommend();

    List<RecommendRankingBooks> ll=  list[0].ranking.books;

    List<RecommendRankingBooks> ll1=  list[1].ranking.books;
  //执行一个随机添加

    listbook.addAll(ll1.toSet());
    listbook.addAll(ll.toSet());

    update(["ZuishuDataPage"]);



    // siaze=await AdSize.getAnchoredAdaptiveBannerAdSize(Orientation.portrait, Get.width.toInt());

  }

  @override
  void onDetached() {

  }

  @override
  void onInactive() {

  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }
  bool first=true;
  @override
  void onResumed() {
   if(first){
     first=false;
     WidgetsBinding.instance.addPostFrameCallback((timeStamp){
       Future.delayed(timeStamp,()async{

       });

     });
   }
  }

}