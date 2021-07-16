import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zzfiction/approute/AppRoutes.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/base/my_cahenetwork_image.dart';
import 'package:zzfiction/base/request.dart';
import 'package:zzfiction/base/screen_manager.dart';
import 'package:zzfiction/controller/ZuiShuController.dart';
import 'package:zzfiction/utils/ADManager.dart';

///整儿八经的数据请求的页面我就遵循原则//追书的排行数据
class ZuishuDataPage extends StatelessWidget {
  BannerAd myBanner = BannerAd(
  adUnitId: ADManager.myID,
  // adUnitId: BannerAd.testAdUnitId,
  size:AdSize.banner,
  request: AdRequest(),
  listener: BannerAdListener(),
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZuiShuController>(
      initState: (_){

        myBanner.load();
      },
      dispose: (_){
        myBanner.dispose();
      },

     id: 'ZuishuDataPage',
      init: Get.find<ZuiShuController>(),
      builder: (logic) {
        return SafeArea(
          child: Stack(
            children: [
              ListView.builder(
                  itemCount:logic.listbook.length,
                  itemBuilder: (_, index) {
                   String string= logic.listbook[index].cover;
                return TextButton(
                  onPressed: (){
                        Get.toNamed(AppPage.Searchpage,arguments:{"data":logic.listbook[index].title,"showAnimation":true});
                  },
                  child: Card(

                    child: Row(

                      children: [
                        MyCachedNetworkImage(withHostName:false,imageUrl: Uri.decodeFull(string.substring(7,string.length))),
                        SizedBox(width: 10,),

                        Expanded(
                          flex: 1,
                            child: SizedBox(
                             height: 170,
                              child: Column(

                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(logic.listbook[index].title,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                                  Text(logic.listbook[index].shortIntro,style: TextStyle(),maxLines: 4,),
                                ],
                              ),
                            ),

                        ),
                      ],
                    ),
                  ),
                );
              }),
             Positioned(
               bottom: 1,

                 child:Container(
                   height:50,
                   width: Get.width,
                   child: Center(child: Container(
                       height:50,
                       width: 330,
                       child: AdWidget(ad: myBanner))),
                 ),),

            ],
          ),
        );
      },
    );
  }

}