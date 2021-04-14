import 'package:get/get.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/binding/HomeBinding.dart';
import 'package:zzfiction/binding/SearchBinding.dart';
import 'package:zzfiction/page/SearchDatapage.dart';
import 'package:zzfiction/page/SearchPage.dart';
import 'package:zzfiction/page/home_page.dart';

class AppRoutes{
    static final String INITIAL=PageName.HOME;
    static final routes = [
    GetPage(name: PageName.HOME, page: ()=>HomePage(),binding: HomeBinding()),
    GetPage(name: PageName.Searchpage, page: ()=>SearchPage(),binding:SearchBinding()),
    GetPage(name: PageName.SearchDatapage, page: ()=>SearchDatapage()),
    ];

}