import 'package:get/get.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/bean/FictionSource.dart';

import '../SearchEngine.dart';

class FictionRepository {
  //当前的某个网站源
  FictionSource currentFictionSource=FictionSource();
  //当前的章节
  FictionChapter  currentFictionChapter=FictionChapter();
  List<FictionSource> fss=[];
    //更新当前阅读列表的list
    Future<FictionSource> updateFictionSourceList()async{
        await SearchEngine().openSourceToGetDirs(currentFictionSource);
      return currentFictionSource;
    }
    toDirPage(int index)async{
      //这里应该是获取链接,判断链接的前后 然后再看是否拼接
      String s= await SearchEngine().getSingleChapterContent(currentFictionSource,index);
      print(s);
      currentFictionSource.chapters[index].content=s;
      currentFictionSource.readdingChapter=index;
      currentFictionChapter=currentFictionSource.chapters[index];
      Get.toNamed(PageName.ReadPage);
    }
    getFictionDirs(int index)async{
     currentFictionSource=fss[index];
      await updateFictionSourceList();
      Get.toNamed(PageName.FictionDirpage);
    }



}