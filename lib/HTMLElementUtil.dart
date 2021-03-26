import 'package:html/dom.dart';

class HTMLElementUtil{
  //把所有子元素的内容转成String//一般用于获取正文内容
  static getAllChildrenContentToString(Element element){
    StringBuffer sb=StringBuffer();
    List<Element> children = element.children;
    for(Element ele in children){
      sb.writeln(ele.text);
    }
    return sb.toString();

  }
  ////把所有子元素的内容转成List

}

