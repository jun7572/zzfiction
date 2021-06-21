import 'dart:collection';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zzfiction/utils/MeasureStringUtil.dart';

class AppSettingUtil{
  static final String _readdingSetting="readdingSetting";
    static final String _fontHeight="_fontHeight";
    static final String _fontsize="_fontsize";
    static final String _SearchHistory="_SearchHistory";
    static final String _SearchHistory_content="_SearchHistory";

    //主题
    static  String _readMode="readTheme";



  static init()async{
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);


  }

  //阅读界面的设置
  //字体大小啥的

  static Future initReaddingSetting()async{
    Box box = await Hive.openBox(_readdingSetting);
    double height1=box.get(_fontHeight);
    double fontsize1=box.get(_fontsize);

    MeasureStringUtil.setTextSize(fontsize1??23, height1??2.0);

  }

  static Future<bool>  getReadTheme()async{
    Box box = await Hive.openBox(_readdingSetting);
   return box.get(_readMode);
  }
  static   setReadTheme(bool b)async{
    Box box = await Hive.openBox(_readdingSetting);
    box.put(_readMode,b);

  }
  static   setSearchHistory(List<String> list)async{
    Box box = await Hive.openBox(_SearchHistory);
    box.put(_SearchHistory_content,list);
  }
  static Future< List<String>>   getSearchHistory()async{
    Box box = await Hive.openBox(_SearchHistory);
    return box.get(_SearchHistory_content);
  }


  static Future<bool> setLineHeight(double sum)async{
    Box box = await Hive.openBox(_readdingSetting);
    box.put(_fontHeight,sum);
  }
  static Future<bool> setFontSize(double sum)async{
    Box box = await Hive.openBox(_readdingSetting);
    box.put(_fontsize,sum);
  }
  //PageNum
   static final String _BrightnessColor="BrightnessColor";
  //保存当前章节的页数
  static  setBrightnessColor(int sum)async{
    Box box = await Hive.openBox(_readdingSetting);
    box.put(_BrightnessColor,sum);
  }
  static Future<int> getBrightnessColor()async{
    Box box = await Hive.openBox(_readdingSetting);
    return box.get(_BrightnessColor)??0xFFCCE8CF;
  }



}
