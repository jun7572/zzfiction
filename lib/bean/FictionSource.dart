import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
//dang
class FictionSource with ChangeNotifier,DiagnosticableTreeMixin{
  //当前标题
  String title;
  //搜出来的路径//作为数据库的id并且是当前的id拉满的
  String path;
  //当前网址的域名
  String host;
  String scheme;

  List<FictionChapter> chapters=[];
  //是不是restful风格的地址,可以根据是不是拼接地址
  String restful;
  //字符集
  String charset;
  //正在阅读的那章,数据也存这个吧
  int readdingChapter;
  //数据库id
  int id;
  //新增使用哪个源字段 //0 1 2
  // 0是在初始化的时候使用,1是使用path1 2是使用path2
  int usePathIndex=0;
  FictionSource({this.path,this.title});

  setChapters( List<FictionChapter> chapters){
    this.chapters=chapters;
    notifyListeners();
  }

  updateSource(FictionSource fs){
    this.title=fs.title;
    this.path=fs.path;
    this.host=fs.host;

    this.chapters=fs.chapters;
    this.restful=fs.restful;
    this.charset=fs.charset;
    this.scheme=fs.scheme;
    notifyListeners();
  }
  FictionSource.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    path = json['path'];
    host = json['host'];
    scheme = json['scheme'];
    readdingChapter = json['readdingChapter'];

    charset = json['charset'];
    restful = json['restful'];
    id = json['fiction_id'];
    usePathIndex = json['usePathIndex'];

  }
  // String str='CREATE TABLE $table (fiction_id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, path TEXT,host TEXT,index INTEGER,restful BLOB,charset TEXT,readdingChapter INTEGER)';
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['path'] = this.path;
    data['host'] = this.host;
    data['scheme'] = this.scheme;

    data['charset'] = this.charset;
    data['fiction_id'] = this.id;
    data['usePathIndex'] = this.usePathIndex;
    data['readdingChapter'] = this.readdingChapter;
    data['restful'] = this.restful.toString();

    return data;
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
    //拼接1
    String absPath;
    //拼接2
    String absPath2;
    String content;
    //哪一本书
    int fictionId;
    int id;
    //实时计算出来的list //好像没用啊
    List<FictionChapterStr> listStr;
    int index;

    FictionChapter({this.title, this.path, this.absPath,this.absPath2});
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['title'] = this.title;
      data['path'] = this.path;
      data['absPath'] = this.absPath;
      data['absPath2'] = this.absPath2;

      data['content'] = this.content;
      data['fictionId'] = this.fictionId;
      data['id'] = this.id;

      return data;
    }


    FictionChapter.fromJson(Map<String, dynamic> json) {
      title = json['title'];
      path = json['path'];
      absPath = json['absPath'];
      absPath2 = json['absPath2'];
      content = json['content'];
      fictionId = json['fictionId'];
      id = json['id'];
      index=0;
    }

}
//一章分很多页
class FictionChapterStr{
  int index;
  String content;
  int id;
  String title;
  //总页数大小
  int totalSize;

  FictionChapterStr(this.index, this.content, this.id,this.title,this.totalSize);
}
