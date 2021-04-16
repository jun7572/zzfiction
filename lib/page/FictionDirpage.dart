import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
//目录页面
class FictionDirpage extends StatelessWidget{
  FictionRepository fs= Get.find<FictionRepository>();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: fs.currentFictionSource.chapters.length,
          itemBuilder:  (_,index){
            return TextButton(child: Padding(padding: EdgeInsets.all(5),child: Text( fs.currentFictionSource.chapters[index].title),),onPressed: ()async{
              fs.toDirPage(index);

            },);
          }),
    );
  }

}