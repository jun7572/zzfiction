import 'package:flutter/foundation.dart';

void main(){
  String sss="/agent/http%3A%2F%2Fimg.1391.com%2Fapi%2Fv1%2Fbookcenter%2Fcover%2F1%2F3417496%2F3417496_a6e906f3d7504ce892483751965b1346.jpg%2F";
  var uri = Uri.decodeFull(sss.substring(7,sss.length));
  print(uri);
}