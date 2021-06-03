import 'package:get/get.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/binding/HomeBinding.dart';
import 'package:zzfiction/binding/ReadBinding.dart';
import 'package:zzfiction/binding/SearchBinding.dart';
import 'package:zzfiction/page/FictionDirpage.dart';
import 'package:zzfiction/page/Readpage.dart';
import 'package:zzfiction/page/SearchDatapage.dart';
import 'package:zzfiction/page/SearchPage.dart';
import 'package:zzfiction/page/SetReaddingOptionPage.dart';
import 'package:zzfiction/page/home_page.dart';

class AppRoutes{
    static final String INITIAL=AppPage.HOME;
    static final routes = [
    GetPage(name: AppPage.HOME, page: ()=>HomePage(),binding: HomeBinding()),
    GetPage(name: AppPage.Searchpage, page: ()=>SearchPage(),binding:SearchBinding()),
    GetPage(name: AppPage.ReadPage, page: ()=>ReadPage(),binding:ReadBinding()),
    GetPage(name: AppPage.SearchDatapage, page: ()=>SearchDatapage()),
    GetPage(name: AppPage.FictionDirpage, page: ()=>FictionDirpage()),
    GetPage(name: AppPage.SetReaddingOptionPage, page: ()=>SetReaddingOptionPage()),
    ];

}