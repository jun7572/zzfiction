
import 'package:get/get.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/db/DataBaseManager.dart';
import 'package:zzfiction/base/DialogUtil.dart';

import '../SearchEngine.dart';
//这层出去的尽量都是实体,不要在controller进行数据库操作
class FictionRepository {
  //当前的某个网站源
  FictionSource currentFictionSource=FictionSource();
  //当前的章节
  FictionChapter  currentFictionChapter=FictionChapter();

  //本地存储的书库的
  List<FictionSource> localFss=[];
    //更新当前阅读列表的list

    toDirPage(int index)async{
      DialogUtil.showLoading();
      //这里应该是获取链接,判断链接的前后 然后再看是否拼接
      String s= await SearchEngine().getSingleChapterContent(currentFictionSource,index);

      currentFictionSource.chapters[index].content=s;
      currentFictionSource.readdingChapter=index;
      currentFictionChapter=currentFictionSource.chapters[index];
      DialogUtil.dismissLoading();
      Get.toNamed(AppPage.ReadPage);
    }

    //查询所有的本地书籍
   queryAllLocalBook()async{
      List<Map<String,dynamic>> fictionSource =await DataBaseManager().queryAllLocalFiction();
      List<FictionSource> list=[];
      fictionSource.forEach((element) {
        print(element.toString());
        var fictionSource2 = FictionSource.fromJson(element);
        list.add(fictionSource2);
      });
      localFss= list;

    }

  //打开书库的一本书
 Future<String> openLocalBook(int index)async{
    currentFictionSource=localFss[index];
    currentFictionSource.lastUseTime=DateTime.now().millisecondsSinceEpoch;
    //更新使用时间
    await DataBaseManager().updateFictionLastTime(currentFictionSource);
    List<FictionChapter> list= await DataBaseManager().queryChapters( currentFictionSource.id);
    currentFictionSource.chapters=list;
    //内容是空的话 去网络获取
    if(currentFictionSource.chapters[currentFictionSource.readdingChapter].content==null){
      var s = await SearchEngine().getSingleChapterContent(currentFictionSource, currentFictionSource.readdingChapter);
      currentFictionChapter= currentFictionSource.chapters[currentFictionSource.readdingChapter];
      currentFictionChapter.content=s;
      return s;
    }else{
     currentFictionChapter= currentFictionSource.chapters[currentFictionSource.readdingChapter];
      return currentFictionSource.chapters[currentFictionSource.readdingChapter].content;
    }
  }
  Future deleteOneLocalBook(int index)async{
    FictionSource  c=localFss[index];
   await DataBaseManager().deleteOneBook(c);
    localFss.removeAt(index);
    // currentFictionSource.chapters.
    return ;
  }
  //打开一张
  openOneChapter(){

  }
  saveOneChapter(){

  }




}