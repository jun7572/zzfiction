class FictionSource{
  String title;
  String path;
  int index;
  FictionSource({this.path,this.index,this.title});

  @override
  String toString() {
    return 'FictionSource{title: $title, path: $path, index: $index}';
  }
}