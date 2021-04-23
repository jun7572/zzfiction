import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DataBaseManager {
  final String dataName="test.db";
  final String table="Test";
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
    print("path==="+path);

    var dbpath = join(path,dataName);
    _database= await openDatabase(dbpath,onCreate: createTable,version: 1);

     isInit=true;
     //初始化一个实体类列表,创建表
  }
  // "DROP TABLE IF EXISTS dub_draft",
  Future  createTable(Database db, int newVersion)async{
    //BLOB  Uint8List
    // String str='CREATE TABLE $table (id INTEGER PRIMARY KEY AUTOINCREMENT, voicepath TEXT, ctime TEXT,str TEXT,data_path TEXT,str_voice TEXT,is_always_use INTEGER)';
    String str='create table Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER)';
    String ste='DROP TABLE IF EXISTS Test';

   var batch = db.batch();
    batch.execute(ste);
    batch.execute(str);
    batch.commit();
  }

  Future  insertOneData()async{
    //成功插入返回当前行的id
    Map<String, Object> map={"id":2,"value":1,"name":"aa"};
    return _database.insert(table, map);
  }
  // //[ASC | DESC]; 排序
  Future<List<Map<String,dynamic>>> queryAll()async{
    Future<List<Map<String,dynamic>>>  f=_database.query(table);
    return f;
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