import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'dart:ui' as ui;

class ReadWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return ReadWidgetState();
  }



}
class ReadWidgetState extends State<ReadWidget> with SingleTickerProviderStateMixin{

  // ReadPainter painter =ReadPainter();

  double index=0;
  int pageNums=0;

  double  singleDragDistance=0;
  AnimationController ac;
  Animation<double> animation;
  bool autoMove=false;
//  当前章节的x位移
  FictionRepository fs=Get.find<FictionRepository>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     ac=AnimationController(vsync:this,duration: Duration(milliseconds: 1000));

   //-----------
    double _width=Get.width-(2*17);
    ParagraphBuilder build = ParagraphBuilder(ParagraphStyle(
      fontStyle: FontStyle.normal,
      fontSize: 18,
    ))..pushStyle(ui.TextStyle(color: Colors.black));
    build.addText(fs.currentFictionChapter.content??"啊?空的?");
    // build.addText(s);
    Paragraph build2 = build.build()..layout(ParagraphConstraints(width: _width));
    List<LineMetrics>  lines = build2.computeLineMetrics();
    print("lines=="+lines[0].height.toString());
    //-----

  }
  @override
  Widget build(BuildContext context) {
 return GestureDetector(
   //这里就要知道的是当前总共的位移距离
   onHorizontalDragStart: (DragStartDetails de){
     print("开始拖动");


     // setState(() {
     //
     // });

   },
   //点下去的时候要获取当前的滚动距离
   onHorizontalDragUpdate: (DragUpdateDetails details){

     autoMove=false;
     // index+=details.delta.dx;
     index+=details.delta.dx;
     singleDragDistance+=details.delta.dx;
      if(details.delta.dx!=0){
        print("正在拖动");
        setState(() {

        });
      }

   },
   onHorizontalDragEnd: (DragEndDetails details){
     print("拖动结束");
     autoMove=true;
    if(singleDragDistance>=0){
      pageNums++;

    }else{
      pageNums--;
    }
  
    //开始是从手指松开的地方开始位移
      animation= Tween(begin: pageNums*Get.width+singleDragDistance, end: (pageNums+1)*Get.width).animate(ac);
     animation.addListener(() {
       if(ac.isCompleted){
         autoMove=true;
         singleDragDistance=0;

       }
       setState(() {

       });
     });

    ac.forward();
    setState(() {

    });
   },
   onHorizontalDragCancel: (){
     print("拖动取消");
     autoMove=false;


     singleDragDistance=0;
   },
   child:  CustomPaint(
     painter: ReadPainter(singleDragDistance+(pageNums-1)*Get.width,autoMove,animation?.value??0),
     size: Get.size,
   ),
 );



  }

}

//想做的是一个扔String 进来,回调开始和结束的方法 的 widget
class ReadPainter extends CustomPainter {
  ReadPainter(this.dragDistance,this.autoMove,this.animationValue);
  FictionRepository fs=Get.find<FictionRepository>();
  Paint p=Paint();
  //当前章节的第几页
  int  index =0;

  double dragDistance=0;
  //动画的值
  double animationValue=0;
  //左右间距
  double padding =17;

  Canvas canvas;
  //判断是用户滑动,还是自己回到原位
  bool autoMove;
  @override
  void paint(Canvas canvas, Size size) {
    // this.canvas=canvas;
    // //用一个文字去测量当前设置的高度
    // // String s="啊啊";
    // String sss=fs.currentFictionChapter.content;
    // if(sss.isEmpty){
    //   return;
    // }
    // // tp.text=TextSpan(text: "啊啊",style: TextStyle(fontSize: 18));
    // double _width=size.width-(2*padding);
    // p.color=Colors.white;
    // canvas.drawPaint(p);
    // ParagraphBuilder build = ParagraphBuilder(ParagraphStyle(
    //     fontStyle: FontStyle.normal,
    //     fontSize: 18,
    // ))..pushStyle(ui.TextStyle(color: Colors.black));
    // build.addText(fs.currentFictionChapter.content??"啊?空的?");
    // // build.addText(s);
    // Paragraph build2 = build.build()..layout(ParagraphConstraints(width: _width));
    // List<LineMetrics>  lines = build2.computeLineMetrics();
    //
    //
    // //取当前每页能装多少行//-2是为了避免底下文字超出高度
    // int floor = (size.height/lines[0].height).floor()-2;
    // //这些文字分到屏幕上一共多少页
    // int pageNums=(lines.length/floor).floor();
    // print("当前章节一共"+pageNums.toString()+"页");
    // //得到一页最后一个文字位置,第二页 应该? 也是这个数量
    // int position = build2.getPositionForOffset(Offset(_width,(floor-1)*lines[0].height)).offset;
    //
    // //绘制完成后真正的页数
    // int truePages=0;
    // //开始绘制
    // for(int k=0;k<pageNums;k++){
    //
    //   //当前显示的
    //   int start=position*k;
    //   int end=position*(k+1)>=fs.currentFictionChapter.content.length?fs.currentFictionChapter.content.length:position*(k+1);
    //   //先试试再完善
    //   if(start>=fs.currentFictionChapter.content.length||e>=fs.currentFictionChapter.content.length){
    //     truePages=k;
    //     print("truePages--"+truePages.toString());
    //     break;
    //   }
    //   var substring = fs.currentFictionChapter.content.substring(start,end);
    //   ParagraphBuilder trueLayout = ParagraphBuilder(ParagraphStyle(
    //     fontStyle: FontStyle.normal,
    //     fontSize: 18,
    //   ))..pushStyle(ui.TextStyle(color: Colors.black));
    //   trueLayout.addText(substring+k.toString());
    //
    //   Paragraph paragraph = trueLayout.build()..layout(ParagraphConstraints(width: _width));
    //
    //
    //  if(autoMove){
    //    canvas.drawParagraph(paragraph, Offset(Get.width*k+animationValue, 0));
    //  }else{
    //    //这个默认未交互的时候
    //    canvas.drawParagraph(paragraph, Offset(Get.width*k+padding+dragDistance, 0));
    //  }
    //
    //
    // }
    //
    //


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate!=this;
  }

}
