import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zzfiction/controller/FictionSourceController.dart';
import 'package:zzfiction/controller/SearchController.dart';
import 'package:zzfiction/managers/screen_manager.dart';
import 'package:zzfiction/utils/AppSettingUtil.dart';
import 'package:zzfiction/widget/ReadWidget.dart';

class SearchPage extends GetView<SearchController>{
  @override
  Widget build(BuildContext context) {

   return GetBuilder<SearchController>(
     initState: (state){
       var argument = Get.arguments;
       if(argument!=null){
         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
           controller.textEditingController.text=argument;
           controller.update();
         });
       }

     },
     builder: (ctr){
       return Scaffold(
         appBar: AppBar(

           backgroundColor: Colors.grey[200],
           leading: BackButton(color: Colors.grey,),
           title: Row(
             children: [
               Expanded(
                 flex: 1,
                 child: TextField(
                   controller: controller.textEditingController,
                   decoration: InputDecoration(
                     hintText: "输入小说名",
                     hintStyle: TextStyle(color: Colors.grey),
                   ),
                   // onChanged: controller.onSearchChange,
                 ),
               ),
               SizedBox(width: getWp(20),),
               GestureDetector(onTap: controller.searchContent,child: Text("搜索",style: TextStyle(color: Colors.grey),))
               // GestureDetector(onTap: (){
               //   Navigator.push(context, MaterialPageRoute(builder: (_)=>ReadWidget()));
               //
               // },child: Text("搜索",style: TextStyle(color: Colors.grey),))
             ],
           ),
         ),
         body: SingleChildScrollView(
           child:Column(
             children: [
               Row(children: [
                    SizedBox(width: getWp(33),),
                 Text("搜索历史",style: TextStyle(fontSize: getSp(15)),),  Spacer(),

                 IconButton(onPressed: ()async{
                      AppSettingUtil.setSearchHistory([]);
                      await  controller.init();
                      controller.update();


                 }, icon: Icon(Icons.restore_from_trash_sharp,color: Colors.black,)),
                 SizedBox(width: getWp(33),),
               ],),
               Wrap(children: controller.getHis(),spacing: 5,),
             ],
           ),
         ),
       );
     },
   );
  }

}