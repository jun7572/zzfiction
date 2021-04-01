class FictionSource{
  //当前标题
  String title;
  //搜出来的路径
  String path;
  //当前网址的域名
  String host;
  int index;
  List<FictionChapter> chapters=[];
  //是不是restful风格的地址,可以根据是不是拼接地址
  bool restful;
  FictionSource({this.path,this.index,this.title});

  @override
  String toString() {
    return 'FictionSource{title: $title, path: $path, index: $index}';
  }
}
//章节
class FictionChapter{
    String title;
    String path;
    String absPath;

    FictionChapter({this.title, this.path, this.absPath});
}