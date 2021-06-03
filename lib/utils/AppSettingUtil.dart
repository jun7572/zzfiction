import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zzfiction/utils/MeasureStringUtil.dart';

class AppSettingUtil{
  static final String _readdingSetting="readdingSetting";
    static final String _fontHeight="_fontHeight";
    static final String _fontsize="_fontsize";

    //主题
    static  String _readMode="readTheme";

  static init()async{
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);


  }

  //阅读界面的设置
  //字体大小啥的

  static initReaddingSetting()async{
    Box box = await Hive.openBox(_readdingSetting);
    int height1=box.get(_fontHeight);
    int fontsize1=box.get(_fontsize);

  MeasureStringUtil.setTextSize(fontsize1??18, height1??1.8);
  }

  static Future<bool>  getReadTheme()async{
    Box box = await Hive.openBox(_readdingSetting);
   return box.get(_readMode);
  }
  static   setReadTheme(bool b)async{
    Box box = await Hive.openBox(_readdingSetting);
    box.put(_readMode,b);

  }

}
