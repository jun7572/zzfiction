


import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:xpath_parse/xpath_selector.dart';
import 'package:path/path.dart' as path ;


import 'package:zzfiction/bean/FictionSource.dart';
import 'package:zzfiction/main.dart';

// <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

class SearchEngine{
  Map<String, String> headers = {"Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "user-agent":"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.104 Safari/537.36 Core/1.53.4882.400 QQBrowser/9.7.13059.400",
    "Accept-Charset":"utf-8;q=0.7,*;q=0.7",
    "Accept-Language":"zh-cn,zh;q=0.5",
     "Accept-Encoding":"gzip, deflate"

  };
  static String path360="https://www.so.com/s?q=";
  //网址,章节list 前几章的内容
  //返回当前结果list 自己定义一个类 看要什么数据
  Future<List<FictionSource>>  search360(String content)async{

    var url = path360+content+" 小说";
    var response = await http.get(url,headers: headers);
    Document document = parse(response.body);
    //获取返回的结果,通过css 去判断
    List<Element> re = document.getElementsByClassName("result");//该标签下的内容
    //获取这个result的list,每个就是一条数据
    //获取名字 最好有简介 还有链接
    List<Element> lists= re[0].children;
    //每个元素就是一个 li,就是当前网页的一个item
    List<FictionSource> lst=[];
    for(Element e in lists){
      FictionSource fs=FictionSource();
      //为了获取链接
      List<Element> elementsByTagName = e.getElementsByTagName("a");
        for(Element ee in elementsByTagName){
          LinkedHashMap<dynamic, String> map = ee.attributes;
          String link= map["data-mdurl"]??"";
          if(link.isNotEmpty){
            fs.path=link;
            fs.title=content;
            lst.add(fs);
           break;
          }
          //描述 res-desc
          // String s=lh["desc"];
          // print("asdf="+s.toString());

        }

      print("\n");
    }
    for(FictionSource fss in lst){
      print(fss.toString());
    }
        return lst;
  }
  //有些信息可以去获取<head>标签
  //打开某个Url,返回内容
  //  通过a去获取 文章列表
  Future<FictionSource> openUrlToGetContent(FictionSource fs)async{
    String url=fs.path;
    //处理一下
    getHostAndSetRestful(fs);
    var response = await http.get(url,headers: headers);
    String charSet = getCharset(response);

    Document document;
    if(charSet=="gbk"){
      document = parse(gbk.decode(response.body.codeUnits));
    }
    else if(charSet=="utf-8"){
       document = parse(utf8.decode(response.body.codeUnits));
    }else{
      document = parse(response.body);
    }
    // List<Element>  query = XPath.source(response.body).query("//a").elements();
    List<Element>  query = document.body.getElementsByTagName("a");

    List<FictionChapter> lists=[];
    query.forEach((element) {
     if( element.text.contains("章")){
       lists.add(FictionChapter(title:element.text.toString(),path:element.attributes["href"]));
     }
    });
    fs.chapters=lists;
    return fs;
   

  }
  //<meta http-equiv="Content-Type" content="text/html; charset=gbk">
  //获取当前网页的字符集//不能通过header去获取,不准,最好是去拿head标签的contenttype
 String getCharset(var response){
   var response2 = response as http.Response;
   // String attribute11=  XPath.source(response2.body).query("//head").get();
   // print("attribute11=="+attribute11);
    String attribute = XPath.source(response2.body).query("//meta[@http-equiv='Content-Type']").get();
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
   getHostAndSetRestful(FictionSource fs){

    String url=fs.path;
    if(url.contains("http")){

      Uri u = Uri.parse(url);
      fs.host=u.host;
      bool orNot = _setFictionRestfulOrNot(fs.path);
      fs.restful=orNot;
    }else{
      throw Exception("无http字符");
    }

  }

  //设置是不是restful风格的
  bool _setFictionRestfulOrNot(String url){
    if(url.contains("html")){
      return false;
    }else{
      return true;
    }
  }

}