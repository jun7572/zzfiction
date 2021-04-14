

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

class SearchDatapage extends StatelessWidget{
  FictionRepository fs= Get.find<FictionRepository>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(),
      body: ListView.builder(
          itemCount: fs.fss.length,
          itemBuilder:  (_,index){
            return TextButton(child: Padding(padding: EdgeInsets.all(5),child: Text( fs.fss[index].title),),onPressed: ()async{
              // String absPath;
              //这里应该是获取链接,判断链接的前后 然后再看是否拼接

              // FictionSource fs=context.read<FictionSource>();
              // String s= await SearchEngine().getSingleChapterContent(fs,index);
              // context.read<FictionSource>().chapters[index].content=s;
              // context.read<FictionSource>().readdingChapter=index;
              //
              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              //   return Test3();
              // }));
              //
              //
            },);
          }),
    );
  }

}