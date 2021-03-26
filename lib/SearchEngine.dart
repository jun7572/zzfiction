


import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:zzfiction/bean/FictionSource.dart';

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
  //不通过啥class  通过dl ul ol 去获取 文章列表
  openUrlToGetContent(String url)async{
    var response = await http.get(url,headers: headers);
    response.headers
    //意思要获取编码  header
    Document document = parse(utf8.decode(response.body.codeUnits));
    // Document document = parse(gbk.decode(response.bodyBytes));

    // Document document = parse(response.body);
    List<Element>  elementsByTagName = document.getElementsByTagName("li");
    List<Element>  elementsByTagName2 = document.getElementsByTagName("dd");
    List<Element>  elementsByTagName3 = document.getElementsByTagName("dt");


    //互斥的?一般只有一个
    if(elementsByTagName!=null){
      for(Element ss in elementsByTagName){
        print(ss.innerHtml.toString());
      }
    }
    if(elementsByTagName2!=null){
      for(Element ss in elementsByTagName2){
        print(ss.outerHtml);
      }
    }
    if(elementsByTagName3!=null){
      for(Element ss in elementsByTagName3){
        print(ss.innerHtml.toString());
      }
    }

  }


}