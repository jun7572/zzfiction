import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

//目录页面 //用于打开网络的?
class FictionDirpage extends StatelessWidget {
  FictionRepository fs = Get.find<FictionRepository>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('一共${fs.currentFictionSource.chapters.length}章'),
      ),
      body: ListView.builder(
          itemCount: fs.currentFictionSource.chapters.length,
          itemBuilder: (_, index) {
            return Column(
              children: [
                TextButton(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(fs.currentFictionSource.chapters[index].title,style: TextStyle(color: Colors.black),),
                  ),
                  onPressed: () async {
                    fs.toDirPage(index);
                  },
                ),
                Divider(height: 1,)
              ],
            );
          }),
    );
  }
}
