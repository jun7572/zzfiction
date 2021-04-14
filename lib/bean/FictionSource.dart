import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
//dang
class FictionSource with ChangeNotifier,DiagnosticableTreeMixin{
  //当前标题
  String title;
  //搜出来的路径
  String path;
  //当前网址的域名
  String host;
  String scheme;

  int index;
  List<FictionChapter> chapters=[];
  //是不是restful风格的地址,可以根据是不是拼接地址
  bool restful;
  //字符集
  String charset;
  int readdingChapter;
  FictionSource({this.path,this.index,this.title});
  setChapters( List<FictionChapter> chapters){
    this.chapters=chapters;
    notifyListeners();
  }

  updateSource(FictionSource fs){
    this.title=fs.title;
    this.path=fs.path;
    this.host=fs.host;
    this.index=fs.index;
    this.chapters=fs.chapters;
    this.restful=fs.restful;
    this.charset=fs.charset;
    this.scheme=fs.scheme;
    notifyListeners();
  }




  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
    super.debugFillProperties(properties);
     properties.add(IterableProperty("chapters",chapters));

  }
    tosString(){
        print("path=="+path);
    }

}
//章节
class FictionChapter{
    String title;
    String path;
    String absPath;
    String content;
    FictionChapter({this.title, this.path, this.absPath});
}