import 'package:get/get.dart';
import 'package:zzfiction/controller/SearchController.dart';
import 'package:zzfiction/repository/FictionRepository.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {

   Get.lazyPut(() => SearchController());

  }

}