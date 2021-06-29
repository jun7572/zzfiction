import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/test/Test2.dart';
import 'package:zzfiction/binding/HomeBinding.dart';
import 'package:zzfiction/theme/ThemeUtil.dart';
import 'package:zzfiction/utils/AppSettingUtil.dart';
import 'package:zzfiction/utils/PreloadManager.dart';
import 'package:zzfiction/utils/path_util.dart';
import 'package:zzfiction/utils/push_manager.dart';

import 'approute/AppRoutes.dart';
import 'bean/FictionSource.dart';

import 'db/DataBaseManager.dart';
import 'managers/screen_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness: Brightness.dark);

    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);


  }
  ErrorWidget.builder = (errorDetails) {
    return Builder(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text("出错了"),
        ),
      );
    });
  };

  runApp(MyApp());
  DataBaseManager().init();
  await  AppSettingUtil.init();
  AppSettingUtil.initReaddingSetting();
  PreloadManager().init();
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppSttate();
  }

}
class AppSttate extends State<MyApp> with WidgetsBindingObserver{
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if(state==AppLifecycleState.resumed){
    // PushManager.clearBadge();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // PushManager.init(context);
    });
  }
  @override
  Widget build(BuildContext context) {
   return GetMaterialApp(
     title: 'Flutter Demo',
     theme: ThemeUtil.getlitghTheme(),
     // home: MyHomePage(title: 'Flutter Demo Home Page'),
     initialRoute: AppRoutes.INITIAL,
     getPages: AppRoutes.routes,

     builder: (BuildContext context, Widget child) {
       initScreen(width: 375, height: 667);
       return child;
     },

   );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key}) : super(key: key);
//
//   String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   List<FictionSource> search360 = [];
//   void _incrementCounter() async {
//     // search360 =await SearchEngine().search360("万族之劫");
//     search360 = await SearchEngine().search360("烂柯棋缘");
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text("asfasdf"),
//       ),
//       body: ListView.builder(
//           itemCount: search360.length,
//           itemBuilder: (_, index) {
//             return GestureDetector(
//               onTap: () async {
//                 print("asdfa");
//                 FictionSource openUrlToGetContent =
//                     await SearchEngine().openSourceToGetDirs(search360[index]);
//
//                 context.read<FictionSource>().updateSource(openUrlToGetContent);
//
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (BuildContext context) {
//                   return Test2();
//                 }));
//               },
//               child: Column(
//                 children: [
//                   Text(search360[index].title + "\n\n"),
//                   Text(search360[index].path),
//                   Divider(
//                     height: 2,
//                     color: Colors.blueGrey,
//                   ),
//                 ],
//               ),
//             );
//           }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
