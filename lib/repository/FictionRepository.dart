import 'package:zzfiction/bean/FictionSource.dart';

import '../SearchEngine.dart';

class FictionRepository {
  //当前的源
  FictionSource currentFictionSource=FictionSource();
  List<FictionSource> fss=[];
    //更新当前的list
    updateFictionSourceList()async{
      await SearchEngine().openUrlToGetSource(currentFictionSource);

    }

}