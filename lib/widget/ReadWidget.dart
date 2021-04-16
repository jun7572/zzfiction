import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

class ReadWidget extends StatelessWidget{
  ReadPainter painter =ReadPainter();

  @override
  Widget build(BuildContext context) {
   return CustomPaint(
     painter: painter,
     size: Get.size,

   );
  }

}
class ReadPainter extends CustomPainter{
  FictionRepository fs=Get.find<FictionRepository>();
  int index=0;
  String ss="";
  @override
  void paint(Canvas canvas, Size size) {
    ParagraphBuilder build = ParagraphBuilder(ParagraphStyle());
    build.addText(fs.currentFictionChapter.content);
   var build2 = build.build();
    canvas.drawParagraph(build2, Offset(0, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {

  }

}