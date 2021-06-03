import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/utils/PrintUtil.dart';



class DataBaseManager {
  final String dataName="zzfiction.db";
  //小说列表
  final String table="Zzfiction";
  //章节
  final String tableChapter="ZzfictionChapter";
  static DataBaseManager _manager=DataBaseManager._internal();
  factory DataBaseManager(){
    return _manager;
  }
  DataBaseManager._internal();
  bool isInit=false;
  static Database _database;

  init()async{
    // /data/user/0/yueyu.june.jun.yueyu/databases
    String path=await getDatabasesPath();
    PrintUtil.prints("path==="+path);

    var dbpath = join(path,dataName);
    _database= await openDatabase(dbpath,onCreate: createTable,version: 1);

     isInit=true;
     //初始化一个实体类列表,创建表
  }
  // "DROP TABLE IF EXISTS dub_draft",

  //  String title;
  //     String path;
  //     String absPath;
  //     String content;
  Future  createTable(Database db, int newVersion)async{
    //BLOB  Uint8List
    String str='CREATE TABLE $table (fiction_id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, path TEXT,host TEXT,scheme TEXT,restful TEXT,charset TEXT,readdingChapter INTEGER,usePathIndex INTEGER)';
    String str1='CREATE TABLE $tableChapter (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, path TEXT,absPath TEXT,absPath2 TEXT,content TEXT,fictionId INTEGER)';
    // String str='create table Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER)';
    // String ste='DROP TABLE IF EXISTS $table';

   var batch = db.batch();
    // batch.execute(ste);
    batch.execute(str);

    batch.execute(str1);
    batch.commit();
  }
  //插入一本小说
  Future  insertOneFiction(FictionSource fictionSource)async{
    //成功插入返回当前行的id
    Map<String, Object> map=fictionSource.toJson();
   var id = await _database.insert(table, map);
    PrintUtil.prints("插入书籍id为=="+id.toString());
    Batch batch = _database.batch();
    for(int i=0; i<fictionSource.chapters.length;i++){
      fictionSource.chapters[i].fictionId=id;
      batch.insert(tableChapter, fictionSource.chapters[i].toJson());
    }

    return batch.commit();
  }
  //把新的章节差入数据库
  // 传入一个更新list后的FictionSource
  Future<List<Object>> updateFiction(FictionSource fictionSource)async{
    List<FictionChapter> list=  await queryChapters(fictionSource.id);
    List<FictionChapter> newList=[];

    if(fictionSource.chapters.length>list.length){
      Batch batch = _database.batch();
      for(int i=list.length;i<fictionSource.chapters.length;i++){
        PrintUtil.prints('插入${fictionSource.chapters[i].toJson()}');
        batch.insert(tableChapter,  fictionSource.chapters[i].toJson());
      }
    return batch.commit();
    }




  }

  // //[ASC | DESC]; 排序
  Future<List<Map<String,dynamic>>> queryAllLocalFiction()async{
    Future<List<Map<String,dynamic>>>  f=_database.query(table);
    return f;
  }
  //查询所有的章节
  Future<List<FictionChapter>> queryChapters(int id)async{
    // _database.query(table,where:'str=?',whereArgs: [str]);
     List<Map<String, Object>> list= await _database.query(tableChapter,where:'fictionId=?',whereArgs: [id]);
     List<FictionChapter> list1=[];
     list.forEach((element) {

       list1.add(FictionChapter.fromJson(element));
     });
     return list1;


  }
  //插入一章的内容,当前的那章??
  updateOneChapterContent(FictionChapter fictionChapter){
    PrintUtil.prints("跟新一章的内容");
        //todo
      // String strsql='UPDATE $tableChapter  SET content = ?, [${fictionChapter.content}])';
    // _database.rawUpdate( );
    _database.update(tableChapter,fictionChapter.toJson(),where: 'id=?',whereArgs: [fictionChapter.id]);

  }
  //插入一章的内容,当前的那章??
  updateOneFiction(FictionSource fictionSource){

    _database.update(table,fictionSource.toJson(),where: 'fiction_id=?',whereArgs: [fictionSource.id]);
  }
  deleteOneBook(FictionSource fictionSource)async{
    await _database.delete(tableChapter,where: 'fictionId=?',whereArgs: [fictionSource.id]);
   await _database.delete(table,where: 'fiction_id=?',whereArgs: [fictionSource.id]);


 }



  // Future<int>  updateUseful(Voice v){
  //  return _database.update(table, v.toJson(),where: "id=?",whereArgs: [v.id]);
  // }
  // Future queryBySingleChinese(String str){
  //
  //   Future<List<Map<String,dynamic>>>  f= _database.query(table,where:'str=?',whereArgs: [str]);
  //   return f;
  // }
  // Future<List<Map<String,dynamic>>>  queryUseFul(){
  //
  //   Future<List<Map<String,dynamic>>>  f= _database.query(table,where:'is_always_use=?',whereArgs: [1]);
  //   return f;
  // }
  // Future deleteData(){
  //   int id=1;
  //   return _database.delete(table,where:'id=?',whereArgs: [id]);
  // }
  static Future close() async {

    return _database.close();
  }

}