import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasureStringUtil{
  static double padding = 17;
  //页面高
  static double windowsHeight=Get.height-Get.statusBarHeight;
  static double windowsWidth= Get.width - (2 * padding);
  static double  _fontSize=20;
  static double  _fontHeight=1.8;

  static double  get size=>_fontSize;
  static double   get height=>_fontHeight;

  /// 下面留多点空间防超出屏幕
  static final  int _bottomLinesNum=2;


  static ParagraphStyle paragraphStyle=ParagraphStyle(
    fontStyle: FontStyle.normal,
    fontSize: _fontSize,
    height: _fontHeight,
  );
  static setTextSize(double fontSize,double fontHeight){
    _fontSize=fontSize;
    _fontHeight=fontHeight;
    paragraphStyle=ParagraphStyle(
      fontStyle: FontStyle.normal,
      fontSize: _fontSize,
      height: _fontHeight,
    );
  }
  static Future<List<String>> calculatePageNUms(String string) async {

    double _width =windowsWidth;
    ParagraphBuilder build = ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(color: Colors.black,));
    build.addText(string ?? "啊?空的?");
    // build.addText(s);
    Paragraph build2 = build.build()
      ..layout(ParagraphConstraints(width: _width));
    //文章一共多少行
    List<LineMetrics> lines = build2.computeLineMetrics();

    //每页多少行 //这里有异常要抓//todo
    //算出前5个最高的lineheight
    double maxLineheight = 0;
    if(lines.length<=1){
      return [];
    }
    for (int i = 0; i < 5; i++) {
      if (lines[i].height >= maxLineheight) {
        maxLineheight = lines[i].height;
      }
    }
    //每页少三行 下面计算高度的时候也要减去这个高度
    int perPageLineNum = (windowsHeight / maxLineheight).ceil()-_bottomLinesNum;
    print("每页行数==${perPageLineNum}");
    //这些文字分到屏幕上一共多少页
    int pageNums = (lines.length / perPageLineNum).ceil();

    print("当前章节一共" + pageNums.toString() + "页");

    List<String> list1 = [];


    int currentlineNum = 0;

    for (int k = 0; k < pageNums; k++) {
      //截取方案2
      //有行数 有页面高 求当前页面开始的position 和页面结束的position
      Offset startoffset = Offset(
          0, (windowsHeight- maxLineheight * _bottomLinesNum) * k + (currentlineNum * maxLineheight));
      Offset endoffset = Offset(
          _width,
          (windowsHeight- maxLineheight * _bottomLinesNum) * (k + 1) +
              (currentlineNum * maxLineheight));

      int startpostion = build2.getPositionForOffset(startoffset).offset;
      int endoffposition = build2.getPositionForOffset(endoffset).offset;

      var substring = string
          .substring(startpostion, endoffposition);
      if (!substring.isBlank) {
        list1.add(substring);
      }

      currentlineNum++;
    }
    return list1;

  }
}