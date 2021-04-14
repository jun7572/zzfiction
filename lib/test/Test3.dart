import 'package:flutter/material.dart';

import 'bean/FictionSource.dart';
import 'package:provider/provider.dart';
class Test3 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Test3State();
  }
  
}
class Test3State extends State<Test3>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Text(context.read<FictionSource>().chapters[context.read<FictionSource>().readdingChapter].content),
      ),
    );
  }
  
}