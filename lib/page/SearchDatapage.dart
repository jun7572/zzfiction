

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:native_progress_hud/native_progress_hud.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

import '../SearchEngine.dart';
  //搜索回来的所有数据源
class SearchDatapage extends StatelessWidget{
  FictionRepository fs= Get.find<FictionRepository>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(),
      body: ListView.builder(
          itemCount: fs.fss.length,
          itemBuilder:  (_,index){
            return TextButton(

              child: Card(
               child: Padding(padding: EdgeInsets.all(10),child: Column(
                children: [
                  Text( fs.fss[index].title),

                  Text( fs.fss[index].path),
                ],
              ),),
            ),onPressed: ()async{
              fs.getFictionDirs(index);
            },);
          }),
    );
  }

}