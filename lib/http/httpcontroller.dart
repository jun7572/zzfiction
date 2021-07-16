import 'package:zzfiction/base/request.dart';
import 'package:zzfiction/bean/recommend_entity.dart';

class HttpController{
  ///获取推荐
 static Future<List<RecommendEntity>> getZuiShuRecommend()async{
   List<RecommendEntity> list=[];
   var res=await RequestUtil().get("/ranking/564ef4f985ed965d0280c9c2");
   var res1=await RequestUtil().get("/ranking/564547c694f1c6a144ec979b");
   RecommendEntity fromJson = RecommendEntity().fromJson(res);
   RecommendEntity fromJson1 = RecommendEntity().fromJson(res1);
   list.add(fromJson1);
   list.add(fromJson);
    return list;
  }
}