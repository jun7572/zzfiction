import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasureStringUtil{
  static double padding = 17;
  static Future<List<String>> calculatePageNUms(String string) async {

    double _width = Get.width - (2 * padding);
    ParagraphBuilder build = ParagraphBuilder(ParagraphStyle(
      fontStyle: FontStyle.normal,
      fontSize: 18,

    ))
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
    for (int i = 0; i < 5; i++) {
      if (lines[i].height >= maxLineheight) {
        maxLineheight = lines[i].height;
      }
    }

    int perPageLineNum = ((Get.height-Get.statusBarHeight) / maxLineheight).ceil();
    print("每页行数==${perPageLineNum}");
    //这些文字分到屏幕上一共多少页
    int pageNums = (lines.length / perPageLineNum).ceil();

    print("当前章节一共" + pageNums.toString() + "页");

    List<String> list1 = [];
    int lastposition = 0;
    double lineheight = lines[0].height;
    int currentlineNum = 0;

    for (int k = 0; k < pageNums; k++) {
      //截取方案2
      //有行数 有页面高 求当前页面开始的position 和页面结束的position
      Offset startoffset = Offset(
          0, (Get.height -Get.statusBarHeight- lineheight * 2) * k + (currentlineNum * lineheight));
      Offset endoffset = Offset(
          _width,
          (Get.height -Get.statusBarHeight- lineheight * 2) * (k + 1) +
              (currentlineNum * lineheight));

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