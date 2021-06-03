import 'dart:async';
import 'dart:isolate';

import 'package:get/get.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
//todo 写到一半接着写
class PreloadManager{


  Isolate _isolate;
  bool _running = false;
  static int _counter = 0;
  String notification = "";
  ReceivePort _receivePort;
  ReceivePort get rp=>_receivePort;
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

       // _counter++;
       // String msg = 'notification ' + _counter.toString();
       // print('SEND: ' + msg);
       // sendPort.send(msg);

  }
  static
  void _handleMessage(dynamic data) {
    int index=data as int;
    // print('RECEIVED: ' + data);
    FictionRepository fictionRepository = Get.find<FictionRepository>();
   SearchEngine().getSingleChapterContent(fictionRepository.currentFictionSource,index );
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