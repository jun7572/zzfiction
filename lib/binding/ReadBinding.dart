import 'package:get/get.dart';
import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/controller/SearchController.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

class ReadBinding extends Bindings{
  @override
  void dependencies() {

   Get.lazyPut(() => ReadController());

  }

}