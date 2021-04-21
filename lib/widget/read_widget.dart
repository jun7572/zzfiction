import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

class ReadWidget2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReadWidgetState2();
  }
  
}
//扔一个String  处理成List<String>
class ReadWidgetState2 extends State<ReadWidget2>{
  double padding=17;
  FictionRepository fs=Get.find<FictionRepository>();
  List<String> list=[];
  @override
  void initState() {
    aaaa();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageView.builder(
        itemCount: list.length,
        itemBuilder: (_,index){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: padding),
        height: Get.height,
        width: Get.width,
        child: Text(list[index],style: TextStyle( fontStyle: FontStyle.normal, fontSize: 18,),),
      );
    });
  }
  aaaa()async{
    double _width=Get.width-(2*padding);
    ParagraphBuilder build = ParagraphBuilder(ParagraphStyle(
      fontStyle: FontStyle.normal,
      fontSize: 18,
    ))..pushStyle(ui.TextStyle(color: Colors.black));
    build.addText(fs.currentFictionChapter.content??"啊?空的?");
    // build.addText(s);
    Paragraph build2 = build.build()..layout(ParagraphConstraints(width: _width));
    List<LineMetrics>  lines = build2.computeLineMetrics();
    //窗口大小
    int floor = (Get.height/lines[0].height).floor()-2;
    //这些文字分到屏幕上一共多少页
    int pageNums=(lines.length/floor).floor();
    print("当前章节一共"+pageNums.toString()+"页");
    //得到一页最后一个文字位置,第二页 应该? 也是这个数量
    int position = build2.getPositionForOffset(Offset(_width,(floor-1)*lines[0].height)).offset;
    List<String> list1=[];
    for(int k=0;k<pageNums;k++){
        int start=position*k;
        int end=position*(k+1)>=fs.currentFictionChapter.content.length?fs.currentFictionChapter.content.length:position*(k+1);
          if(start>=fs.currentFictionChapter.content.length||end>=fs.currentFictionChapter.content.length){

            break;
          }
       var substring = fs.currentFictionChapter.content.substring(start,end);
        list1.add(substring);
    }
    list=list1;
    setState(() {

    });

  }
}
