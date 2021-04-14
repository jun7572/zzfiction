import 'package:get/get.dart';
import 'package:zzfiction/controller/FictionSourceController.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FictionSourceController());
    Get.lazyPut(() => FictionRepository());

  }

}