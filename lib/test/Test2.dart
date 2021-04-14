

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zzfiction/SearchEngine.dart';

import 'Test3.dart';
import '../bean/FictionSource.dart';

class Test2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Test2State();
  }
  
}
class Test2State extends State<Test2>   {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: context.watch<FictionSource>().chapters.length,
          itemBuilder:  (_,index){
        return TextButton(child: Padding(padding: EdgeInsets.all(5),child: Text( context.watch<FictionSource>().chapters[index].title),),onPressed: ()async{
          String absPath;
          //这里应该是获取链接,判断链接的前后 然后再看是否拼接

          FictionSource fs=context.read<FictionSource>();
          String s= await SearchEngine().getSingleChapterContent(fs,index);
          context.read<FictionSource>().chapters[index].content=s;
          context.read<FictionSource>().readdingChapter=index;

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
            return Test3();
          }));
        },);
      }),
    );
  }
  
}