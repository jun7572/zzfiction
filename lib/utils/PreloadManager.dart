import 'dart:async';
import 'dart:isolate';

import 'package:get/get.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/utils/PrintUtil.dart';
///预加载管理者
class PreloadManager{


  Isolate _isolate;
  bool _running = false;
  static int _counter = 0;
  String notification = "";
  ReceivePort _receivePort;
  // ReceivePort get rp=>_receivePort;
   init()async{
     _running = true;
    //接受管子
     _receivePort = new ReceivePort();
    SendPort port1 = _receivePort.sendPort;
    //share the same code? 这他妈是新线程?
     _isolate = await Isolate.spawn(_doWork, port1,);
     _receivePort.listen(_handleMessage,onDone: (){
      print("done");
    });
  }

  static  _doWork(SendPort sendPort){
    //新管子?
        LogUtil.prints("asdfasfafasf");
       // _counter++;
       // String msg = 'notification ' + _counter.toString();
       // print('SEND: ' + msg);
       // sendPort.send(msg);

  }
  //看看有没有其他操作
  static  final  String  MESSAGE_LOAD="MESSAGE_LOAD";
  // static  final  String  MESSAGE_LOAD="MESSAGE_LOAD";
  ///内部自定要不要加载
  ///目前加载3章
  load(int chapterNum){
    _receivePort.sendPort.send(MESSAGE_LOAD+",$chapterNum");
  }
  //处理sendPort发的数据
  static void _handleMessage(dynamic data) async{
    String index=data as String;
    List<String>  split = index.split(",");
    LogUtil.prints("预加载${split[1]}");
    // print('RECEIVED: ' + data);
    FictionRepository fictionRepository = Get.find<FictionRepository>();
    int start=int.parse(split[1]);
    int end=start+3;
    if(end>fictionRepository.currentFictionSource.chapters.length){
      end=fictionRepository.currentFictionSource.chapters.length-1;
    }
    for(int i=start;i<end;i++){
     if(fictionRepository.currentFictionSource.chapters[i].content==null||fictionRepository.currentFictionSource.chapters[i].content==SearchEngine.noData){
       await SearchEngine().getSingleChapterContent(fictionRepository.currentFictionSource,i);
     }else{
       continue;
     }
    }

  }

  stop(){
    if (_isolate != null) {
      _running = false;
      _receivePort.close();
      _isolate.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }

  PreloadManager._internal();
  static PreloadManager _preloadManager=PreloadManager._internal();
  factory PreloadManager(){
    return _preloadManager;
  }

}