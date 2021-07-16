import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:zzfiction/controller/FictionSourceController.dart';
import 'package:zzfiction/controller/SearchController.dart';
import 'package:zzfiction/gen_a/A.dart';
import 'package:zzfiction/managers/screen_manager.dart';
import 'package:zzfiction/utils/AppSettingUtil.dart';
import 'package:zzfiction/widget/ReadWidget.dart';

class SearchPage extends GetView<SearchController>{
  @override
  Widget build(BuildContext context) {

   return GetBuilder<SearchController>(
     initState: (state){
       //{"data":logic.listbook[index].title,"showAnimation":true}
       var argument = Get.arguments;
       if(argument!=null){
         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
           controller.textEditingController.text=argument["data"];
           controller.update();
         });
       }

     },
     builder: (ctr){

       return  Scaffold(

         body: SafeArea(
           child: Padding(
             padding:  EdgeInsets.symmetric(horizontal: getWp(38)),
             child: Column(
               children: [

                 //搜索框
               Container(
                  padding: EdgeInsets.symmetric(horizontal: getWp(19)),
                 height: getHp(getHp(33)),
                 // margin: EdgeInsets.symmetric(horizontal: getWp(38),vertical: getHp(26)),
                 margin: EdgeInsets.only(top: getHp(26)),
                 decoration: BoxDecoration(border:Border.all(width: 1,color: Colors.black,),borderRadius: BorderRadius.circular(getWp(10))),
                 child: Row(
                   children: [
                     Expanded(
                       flex:1,
                       child: TextField(


                                   controller: controller.textEditingController,
                                   decoration: InputDecoration(
                                     contentPadding:EdgeInsets.zero,
                                     // border:OutlineInputBorder(),
                                     border:InputBorder.none,
                                     isCollapsed:true,
                                     hintText: "输入小说名",
                                     hintStyle: TextStyle(color: Colors.grey,fontSize: getSp(12)),
                                   ),
                                   // onChanged: controller.onSearchChange,
                                 ),
                     ),


                     AnimatedTextKit(
                       onTap:  controller.searchContent,
                       animatedTexts:[WavyAnimatedText("搜索",textStyle: TextStyle(color: Color(0xffFF831E)),)],
                       stopPauseOnTap: true,
                     )


                   ],
                 ),
               ),

                 //回收哪行
                 SizedBox(height: getHp(14),),
                 Row(children: [
                           Text("搜索历史",style: TextStyle(fontSize: getSp(15)),),
                           Spacer(),


                            GestureDetector(
                              // style: TextButton.styleFrom(padding: EdgeInsets.only(right: 0)),
                              child: Image.asset(A.assets_delete,width: getWp(22),),onTap: ()async{
                              AppSettingUtil.setSearchHistory([]);
                              await  controller.init();
                              controller.update();
                            },),

                 ],),
                  SizedBox(height: getHp(15),),
                  Expanded(
                    flex: 1,
                    child: GridView(
                      children: controller.getHis(),

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3),
                    ),
                  ),

               ],
             ),
           ),
         ),
       );
     },
   );
  }

}