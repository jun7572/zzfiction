import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/controller/FictionSourceController.dart';
import 'package:zzfiction/db/DataBaseManager.dart';
import 'package:zzfiction/gen_a/A.dart';
import 'package:zzfiction/managers/screen_manager.dart';
import 'package:zzfiction/utils/PreloadManager.dart';
import 'package:zzfiction/widget/ReadWidget.dart';

import 'BookRepositoryPage.dart';

class HomePage extends GetView<FictionSourceController> {
  //要有主题 白天 夜晚 或者其他

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: TabBar(
        controller: controller.tc,
        tabs: controller.myTabs,

      ),
      body: TabBarView(controller: controller.tc, children: [
        Column(
          children: [
            Container(

              width: Get.width,

              padding: EdgeInsets.all(getWp(30)),
              child: Column(
                children: [
                  SizedBox(
                    height: getHp(250),
                  ),
                  Row(
                    children: [
                        Spacer(),
                      Image.asset(A.assets_doglogo),
                      SizedBox(width: 30,),
                      Text("菜狗搜索",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: controller.toSearchPgae,
                    // onTap:(){
                    //   Navigator.push(context, MaterialPageRoute(builder: (_)=>ReadWidget()));
                    // },
                    child: Container(
                      width: Get.width,
                      height: getHp(150),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(getHp(100)),
                          border: Border.all(width: 1,color: Colors.black),
                          color: Colors.white),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: getWp(30)),
                          child: Row(
                            children: [
                              Text(
                                "输入搜索的小说名",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.history_rounded,

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
        BookRepositoryPage(),
      ]),
    );
  }
}
