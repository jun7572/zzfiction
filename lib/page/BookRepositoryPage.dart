import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zzfiction/controller/BookRepositoryController.dart';

import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/db/DataBaseManager.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

class BookRepositoryPage extends GetView<BookRepositoryController>{
 final FictionRepository fr=Get.find<FictionRepository>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<BookRepositoryController>(
        init: controller,
        builder: (_){
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
                itemCount: fr.localFss.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio:0.8), itemBuilder: (_,index){
              return ElevatedButton(
                style:ElevatedButton.styleFrom(primary: Colors.white,) ,
                onPressed: (){
                  controller.openLocalBook(index);
                },
                onLongPress: (){
                    controller.deleteOneBook(index);
                },
                child: Container(
                  margin: EdgeInsets.all(4),
                  // color: Colors.grey[100],
                  child: Center(
                    child: TextButton(child: Text(fr.localFss[index].title,style: TextStyle(color: Colors.black),),),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
  
}