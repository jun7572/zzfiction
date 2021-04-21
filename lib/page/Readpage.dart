import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/widget/ReadWidget.dart';
import 'package:zzfiction/widget/read_widget.dart';

class ReadPage extends GetView<ReadController>{
  int index =0;
  //先放里面吧
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ReadWidget2(),
    );
  }

}