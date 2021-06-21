


import 'dart:collection';
import 'dart:convert';

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/dom_parsing.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:http/io_client.dart';
import 'package:xpath_parse/xpath_selector.dart';
import 'package:path/path.dart' as path ;


import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/main.dart';
import 'package:zzfiction/utils/DialogUtil.dart';
import 'package:zzfiction/utils/PrintUtil.dart';

import 'ContentKey.dart';

// <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

class SearchEngine{
  Map<String, String> headers = {"Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "user-agent":"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.104 Safari/537.36 Core/1.53.4882.400 QQBrowser/9.7.13059.400",
    "Accept-Charset":"utf-8;q=0.7,*;q=0.7",
    "Accept-Language":"zh-cn,zh;q=0.5",
    "Accept-Encoding":"gzip, deflate",
    "verify":"False"
  };
  static String path360="https://www.so.com/s?q=";
  //网址,章节list 前几章的内容
  //返回当前结果list 自己定义一个类 看要什么数据
  bool _certificateCheck(X509Certificate cert, String host, int port) =>
      host == 'devblog.paypal.com';

  http.Client paypalClient() {
    var ioClient = new HttpClient()
      ..badCertificateCallback = _certificateCheck;

    return  IOClient(ioClient);
  }
  //todo 试着绕开https证书

  Future<List<FictionSource>>  search360(String content)async{

    var url = path360+content+" 小说";
    var response = await http.get(url,headers: headers);

    dom.Document document = parse(response.body);
    //获取返回的结果,通过css 去判断
    List<dom.Element> re = document.getElementsByClassName("result");//该标签下的内容
    //获取这个result的list,每个就是一条数据
    //获取名字 最好有简介 还有链接
    List<dom.Element> lists= re[0].children;
    //每个元素就是一个 li,就是当前网页的一个item
    List<FictionSource> lst=[];
    for(dom.Element e in lists){
      FictionSource fs=FictionSource();
      //为了获取链接
      List<dom.Element> elementsByTagName = e.getElementsByTagName("a");
        for(dom.Element ee in elementsByTagName){
          LinkedHashMap<dynamic, String> map = ee.attributes;
          String link= map["data-mdurl"]??"";
          if(link.isNotEmpty){
            fs.path=link;
            print("link="+link);
            fs.title=content;
            lst.add(fs);
           break;
          }
          //描述 res-desc
          // String s=lh["desc"];
          // print("asdf="+s.toString());

        }

      PrintUtil.prints("\n");
    }
    for(FictionSource fss in lst){
      PrintUtil.prints(fss.toString());
    }
        return lst;
  }
  Future<List<FictionSource>> search360Loadmore(String content,int pagenum)async{
    var url = path360+content+" 小说&pn=$pagenum";
    var response = await http.get(url,headers: headers);

    dom.Document document = parse(response.body);
    //获取返回的结果,通过css 去判断
    List<dom.Element> re = document.getElementsByClassName("result");//该标签下的内容
    //获取这个result的list,每个就是一条数据
    //获取名字 最好有简介 还有链接
    List<dom.Element> lists= re[0].children;
    //每个元素就是一个 li,就是当前网页的一个item
    List<FictionSource> lst=[];
    for(dom.Element e in lists){
      FictionSource fs=FictionSource();
      //为了获取链接
      List<dom.Element> elementsByTagName = e.getElementsByTagName("a");
      for(dom.Element ee in elementsByTagName){
        LinkedHashMap<dynamic, String> map = ee.attributes;
        String link= map["data-mdurl"]??"";
        if(link.isNotEmpty){
          fs.path=link;
          print("link="+link);
          fs.title=content;
          lst.add(fs);
          break;
        }
        //描述 res-desc
        // String s=lh["desc"];
        // print("asdf="+s.toString());

      }

      PrintUtil.prints("\n");
    }
    for(FictionSource fss in lst){
      PrintUtil.prints(fss.toString());
    }
    return lst;

  }


  //有些信息可以去获取<head>标签
  //打开某个Url,返回内容
  //  通过a去获取 文章列表
  Future<FictionSource> openSourceToGetDirs(FictionSource fs)async{
    String url=fs.path;
    PrintUtil.prints("打开的url="+url);
    //处理一下
    getHostAndSetRestful(fs);
    HttpClient client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port){ return true; };

    var response = await http.get(url,headers: headers);

    String charSet = getCharset(response);
    fs.charset=charSet;
    print("charset=="+charSet);
    //todo 这里到时候可以试试三个 哪个有返回了就使用哪个!
    dom.Document document;
    if(charSet=="gbk"){
      document = parse(gbk.decode(response.body.codeUnits));
    }
    else if(charSet=="utf-8"){

      try{
        document = parse(utf8.decode(response.body.codeUnits));
      }catch(e){
        print(e.toString());
        fs.charset="";
        // document = parse(gbk.decode(response.body.codeUnits));
        document = parse(response.body);
      }
    }else{
      document = parse(response.body);
    }
    // List<Element>  query = XPath.source(response.body).query("//a").elements();
    List<dom.Element>  query = document.body.getElementsByTagName("a");

    List<FictionChapter> lists=[];
    query.forEach((element) {
     if( element.text.contains("章")){
       String  path = element.attributes["href"];
       String absPath,absPath2="";
       //是不是全的网址
       // (path.startsWith("http")||path.startsWith("https"))&&path.endsWith("html")))
       if(path.contains("www")
           ||((path.startsWith("http")||path.startsWith("https"))&&path.endsWith("html"))
       ){
         //处理一下这个全路径
         String temp=path.substring(path.indexOf("www"),path.length);

         absPath=fs.scheme+"://"+temp;
       }else{
         //这里就不对,应该有两种
         absPath=fs.scheme+"://"+fs.host+path;
        absPath2=fs.path+path;
       }
       lists.add(FictionChapter(title:element.text.toString().replaceAll(" ", "").replaceAll("\n", "").trim(),path:path,absPath: absPath,absPath2: absPath2));
     }
    });
    print("章节数=="+lists.length.toString());
    //没有章字的就使用a就行
    if(lists.length<20){
      int length=0;
      List<dom.Element> contentElement=[];

      List<dom.Element>  elementsByTagName = document.body.getElementsByTagName("li");
      List<dom.Element>  elementsByTagName2 = document.body.getElementsByTagName("dd");
      List<dom.Element>  elementsByTagName3 = document.body.getElementsByTagName("dt");
      if(elementsByTagName.length>length){
          length= elementsByTagName.length;
          contentElement=elementsByTagName;
      }
      if(elementsByTagName2.length>length){
        length= elementsByTagName2.length;
        contentElement=elementsByTagName2;
      }
      if(elementsByTagName3.length>length){
        length= elementsByTagName3.length;
        contentElement=elementsByTagName3;
      }


      if(contentElement!=null){
        for(dom.Element ss in contentElement){
          List<dom.Element> lll  = ss.getElementsByTagName("a");
          dom.Element sss= lll[0];
          if(lll!=null&&lll.length>=1){

            String  path = sss.attributes["href"];
            String absPath,absPath2="";
            //是不是全的网址
            // (path.startsWith("http")||path.startsWith("https"))&&path.endsWith("html")))
            if(path.contains("www")
                ||((path.startsWith("http")||path.startsWith("https"))&&path.endsWith("html"))
            ){
              //处理一下这个全路径
              String temp=path.substring(path.indexOf("www"),path.length);

              absPath=fs.scheme+"://"+temp;
            }else{
              //这里就不对,应该有两种
              absPath=fs.scheme+"://"+fs.host+path;
              absPath2=fs.path+path;
            }

            lists.add(FictionChapter(title:sss.text.toString().replaceAll(" ", "").replaceAll("\\n", "").trim(),path:path,absPath: absPath,absPath2: absPath2));
          }

        }
      }

    }
    fs.chapters=lists;
    return fs;
   

  }
  //刷新章节,看完了和手动调用
  Future<FictionSource> refreshLocalDir(FictionSource fs)async{
    String url=fs.path;
    HttpClient client = HttpClient();
    var response = await http.get(url,headers: headers);
    dom.Document document;
    String charSet =fs.charset;
    if(charSet=="gbk"){
      document = parse(gbk.decode(response.body.codeUnits));
    }
    else if(charSet=="utf-8"){

      try{
        document = parse(utf8.decode(response.body.codeUnits));
      }catch(e){
        print(e.toString());
        fs.charset="";
        // document = parse(gbk.decode(response.body.codeUnits));
        document = parse(response.body);
      }
    }else{
      document = parse(response.body);
    }

    List<dom.Element>  query = document.body.getElementsByTagName("a");

    List<FictionChapter> lists=[];
    query.forEach((element) {
      if( element.text.contains("章")){
        String  path = element.attributes["href"];
        String absPath,absPath2="";
        //是不是全的网址
        // (path.startsWith("http")||path.startsWith("https"))&&path.endsWith("html")))
        if(path.contains("www")
            ||((path.startsWith("http")||path.startsWith("https"))&&path.endsWith("html"))
        ){
          //处理一下这个全路径
          String temp=path.substring(path.indexOf("www"),path.length);

          absPath=fs.scheme+"://"+temp;
        }else{
          //这里就不对,应该有两种
          absPath=fs.scheme+"://"+fs.host+path;
          absPath2=fs.path+path;
        }
        lists.add(FictionChapter(title:element.text.toString(),path:path,absPath: absPath,absPath2: absPath2));
      }
    });
    print("章节数=="+lists.length.toString());
    int d=lists.length-fs.chapters.length;
    DialogUtil.showToast("跟新了$d章");
    fs.chapters=lists;
    return fs;
  }



  //<meta http-equiv="Content-Type" content="text/html; charset=gbk">
  //获取当前网页的字符集//不能通过header去获取,不准,最好是去拿head标签的contenttype
 String getCharset(var response){
   var response2 = response as http.Response;
   String attribute;
     attribute = XPath.source(response2.body).query("//meta[@http-equiv='Content-Type']").get();
    if(attribute.isEmpty){
       attribute = XPath.source(response2.body).query("//meta[@https-equiv='Content-Type']").get();
    }
    //集合多个网页的经验
   if(attribute.contains("utf-8")||attribute.contains("UTF-8")){
     return "utf-8";
   }else if(attribute.contains("gbk")||attribute.contains("GBK")){
     return "gbk";
   }

  return "";
  }
  //其实地址就分restful和非restful风格的
  //就按这两种来分吧
  //获取域名
  //这个不好用,根据实际的a标签去控制
   getHostAndSetRestful(FictionSource fs){

    String url=fs.path;
    if(url.contains("http")||url.contains("https")){

      Uri u = Uri.parse(url);
      fs.host=u.host;
      fs.scheme=u.scheme;
      bool orNot = _setFictionRestfulOrNot(fs.path);
      fs.restful=orNot.toString();
    }else{
      throw Exception("无http字符");
    }

  }

  //设置是不是restful风格的
  bool _setFictionRestfulOrNot(String url){
    if(url.endsWith("html")){
      return false;
    }else{
      return true;
    }
  }
  static final String noData="无数据";
  // static String decompress(String zipText) {
  //   final List<int> compressed = base64Decode(zipText);
  //   if (compressed.length > 4) {
  //     Uint8List uint8list = GZipDecoder().decodeBytes(compressed.sublist(4, compressed.length - 4));
  //     // print( String.fromCharCodes(uint8list));
  //     return String.fromCharCodes(uint8list);
  //   } else {
  //     return "";
  //   }
  // }
  //获取单章的内容
 Future<String>  getSingleChapterContent(FictionSource fs,int index)async{
    if(index>=fs.chapters.length){
      return noData;
    }

  String url=  fs.chapters[index].absPath;

    print("单章的地址=="+url);
  print("单章的地址=="+fs.chapters[index].absPath2??"");
  var response;


  if(fs.usePathIndex==0){
    try{
      response = await http.get(url,headers: headers);
      fs.usePathIndex=1;
    }catch(e){
      print(e.toString());
      try{
        response = await http.get(fs.chapters[index].absPath2,headers: headers);
        fs.usePathIndex=2;
      }catch(e){
        print(e.toString());
        return noData;
      }

    }
  }else if(fs.usePathIndex==1){
    response = await http.get(url,headers: headers);
  }else{
    response = await http.get(fs.chapters[index].absPath2,headers: headers);
  }



    String charSet = fs.charset;
  dom.Document document;
  if(charSet=="gbk"){
    document = parse(gbk.decode(response.bodyBytes));
  }
  else if(charSet=="utf-8"){
    // Utf8Codec().decode(response.bodyBytes)
    try{
      document = parse(utf8.decode(response.bodyBytes));
    }catch(e){
      print(e.toString());
      document = parse(gbk.decode(response.bodyBytes));
    }

  }else{
    document = parse(response.body);

  }


  dom.Element contentElement = _getContentElement(document);
    if(contentElement!=null){
      var getText = _getText(contentElement);
      fs.chapters[index].content=getText;
     return getText;
    }

  return noData;
  }
  //获取文章内容//设定好几种方式
  //一种class 一种id  class 又有 content contents Content Contents 直到返回数据为止 当前路径同时保存这个内容的读法
  //后面整个请求接口的? 循环整?
  dom.Element  _getContentElement(dom.Document document){
    dom.Element elementById;
    for(String s in Contentkey.listId){
      elementById = document.getElementById(s);
      if(elementById!=null){
        return elementById;
      }
    }

    //搞个几把,把遇到的放进来就行
    List<String> listStr=Contentkey.list;
    for(String s in listStr){
      List<dom.Element>  list1=document.getElementsByClassName(s);

      if(list1!=null&&list1.length>0){
        return list1[0];
      }

    }


    return null;
  }


}
String _getText(dom.Node node) => (_MyTextVisitor()..visit(node)).toString();



class _MyTextVisitor extends TreeVisitor {
  final _str = StringBuffer();

  @override
  String toString() => _str.toString();

  @override
  void visitText(dom.Text node) {
    node.text= node.text.replaceAll(" ", "").trim();

    if(node.text.isEmpty){

      // _str.write("\n\r");
    }else{
      if(node.data.endsWith("\n")){
        _str.write(node.data);
      }else{
        _str.write("       "+node.data+"\n");
      }


    }

  }


}