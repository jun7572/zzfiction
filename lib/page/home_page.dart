import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/controller/FictionSourceController.dart';
import 'package:zzfiction/managers/screen_manager.dart';




class HomePage extends GetView<FictionSourceController>{
  //要有主题 白天 夜晚 或者其他
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Column(
        children: [
          Container(color: Colors.lightBlue,width: Get.width,height: getHp(700),padding: EdgeInsets.all(getWp(30)),
            child: Column(
              children: [
                SizedBox(height: getHp(250),),

                GestureDetector(
                  onTap: controller.toSearchPgae,
                  child: Container(
                    width:  Get.width,
                    height: getHp(150),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(getHp(30)),color: Colors.white),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 0,horizontal: getWp(30)),
                        child: Row(
                          children: [
                            Text("输入搜索的小说名",style: TextStyle(color: Colors.grey),),
                            Expanded(child: SizedBox()),
                            Icon(Icons.history_rounded,color: Colors.grey,),

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
    );
  }
  
}