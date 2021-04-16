import 'package:get/get.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/binding/HomeBinding.dart';
import 'package:zzfiction/binding/ReadBinding.dart';
import 'package:zzfiction/binding/SearchBinding.dart';
import 'package:zzfiction/page/FictionDirpage.dart';
import 'package:zzfiction/page/Readpage.dart';
import 'package:zzfiction/page/SearchDatapage.dart';
import 'package:zzfiction/page/SearchPage.dart';
import 'package:zzfiction/page/home_page.dart';

class AppRoutes{
    static final String INITIAL=PageName.HOME;
    static final routes = [
    GetPage(name: PageName.HOME, page: ()=>HomePage(),binding: HomeBinding()),
    GetPage(name: PageName.Searchpage, page: ()=>SearchPage(),binding:SearchBinding()),
    GetPage(name: PageName.ReadPage, page: ()=>ReadPage(),binding:ReadBinding()),
    GetPage(name: PageName.SearchDatapage, page: ()=>SearchDatapage()),
    GetPage(name: PageName.FictionDirpage, page: ()=>FictionDirpage()),
    ];

}