import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zzfiction/SearchEngine.dart';
import 'package:zzfiction/test/Test2.dart';
import 'package:zzfiction/binding/HomeBinding.dart';

import 'approute/AppRoutes.dart';
import 'bean/FictionSource.dart';
import 'managers/screen_manager.dart';

void main() {
  ErrorWidget.builder=(errorDetails){
    return Builder(builder: (ctx){
      return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text("出错了"),),
      );
    });
  };


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FictionSource()),

  ],child: MyApp(),));

}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: AppRoutes.INITIAL,
      getPages: AppRoutes.routes,

      builder: (BuildContext context, Widget child) {
        initScreen(width: 1080, height: 1920);
        return child;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<FictionSource> search360=[];
  void _incrementCounter() async{
     // search360 =await SearchEngine().search360("万族之劫");
     search360 =await SearchEngine().search360("烂柯棋缘");
     setState(() {

     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: search360.length,
          itemBuilder: (_,index){
        return GestureDetector(
          onTap: ()async{
            print("asdfa");
            FictionSource openUrlToGetContent =await SearchEngine().openUrlToGetSource(search360[index]);

            context.read<FictionSource>().updateSource(openUrlToGetContent);


            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return Test2();
            }));

          },
          child: Column(
            children: [
              Text(search360[index].title+"\n\n"),

              Text(search360[index].path),
              Divider(height: 2,color: Colors.blueGrey,),
            ],
          ),
        );

      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
