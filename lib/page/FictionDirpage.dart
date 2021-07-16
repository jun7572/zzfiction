import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/gen_a/A.dart';
import 'package:zzfiction/managers/screen_manager.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

///目录页面 //用于打开网络的?
class FictionDirpage extends StatelessWidget {
  FictionRepository fs = Get.find<FictionRepository>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.only(left: getWp(30))),
          onPressed: (){
            Get.back();
          },
          child: Image.asset(A.assets_back),
        ),
        // title: Text('一共${fs.currentFictionSource.chapters.length}章'),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: getWp(35)),
        child: Column(
          children: [
            SizedBox(height: getHp(16),),
            Row(
              children: [
                Text('目录 共${fs.currentFictionSource.chapters.length}章'),

              ],
            ),
            SizedBox(height: getHp(35),),
            Expanded(
              flex: 1,
              child: ListView.builder(

                  itemCount: fs.currentFictionSource.chapters.length,
                  itemBuilder: (_, index) {
                    return TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.white,alignment: Alignment(-1,1),padding: EdgeInsets.all(0)),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(fs.currentFictionSource.chapters[index].title,style: TextStyle(color: Colors.black,fontSize: getSp(12)),),
                      ),
                      onPressed: () async {
                        fs.toDirPage(index);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
