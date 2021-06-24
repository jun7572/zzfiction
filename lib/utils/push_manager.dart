import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
//推送管理

const String _appKey = '3a968153aad27808801610ed';
const String _channel = 'developer-default';

//{alert: 资金变动提醒,
// extras: {cn.jpush.android.ALERT_TYPE: 1,
//  cn.jpush.android.NOTIFICATION_ID: 525271926,
//  cn.jpush.android.MSG_ID: 47287822010445726,
//  cn.jpush.android.BIG_TEXT: 您的'快来订阅我'已于 2019/10/12 15:00:18 划出【USDT】【0.111个】,
//  cn.jpush.android.ALERT: 资金变动提醒,
//  cn.jpush.android.EXTRA: {"id":0,
//    "page":"funds_trans_notice"
//    }
//   },
//  title: 趣跟单}
class PushManager {
  static JPush _jPush;

  //获取在极光服务器注册得id
  static Future<String> getRegisterID() async {
    return await _jPush.getRegistrationID();
  }

  static Future<dynamic> clearNotification() async {
    return await _jPush.clearAllNotifications();
  }

  static Future<dynamic> clearBadge() async {
    if (!Platform.isIOS || _jPush == null) return null;
    return await _jPush.setBadge(0);
  }

  static void init(BuildContext context) {

    _jPush = JPush()
      ..addEventHandler(
        // 接收通知回调方法。
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
        },
          // {alert: 最好看的小说--, extras: {cn.jpush.android.ALERT_TYPE: 7, cn.jpush.android.NOTIFICATION_ID: 466420552, cn.jpush.android.MSG_ID: 9007423954804097, cn.jpush.android.ALERT: 最好看的小说--, cn.jpush.android.EXTRA: {"page":"SearchPage"}}, title: 这主角深井冰？}
        // 点击通知回调方法。
        onOpenNotification: (Map<String, dynamic> message) async {
          Map<String, dynamic> map=message["cn.jpush.android.EXTRA"];
          var map2 = map["page"];
          if(map2!=null){
            Get.toNamed(map2,arguments: map["searchString"]);


          }
          _handleMessage(context, message);
        },
        // 接收自定义消息回调方法。
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
        },
      )
      ..setup(
        appKey: _appKey,
        channel: _channel,
        production: false,
        debug: true,
      )
      ..applyPushAuthority();

    _initLaunchMessage(context);
  }

  static void _initLaunchMessage(BuildContext context) async {
    Map<dynamic, dynamic> result = await _jPush.getLaunchAppNotification();
    if (result != null && result.isNotEmpty) {
      Map<String, dynamic> result2 =
      result.map((k, v) => MapEntry(k as String, v));
      _handleMessage(context, result2);
    }
  }

  static void _handleMessage(
      BuildContext context, Map<String, dynamic> message) async {
    Map<String, dynamic> extras;
    //打开链接
    //{"url":"http:\/\/wwww.baidu.com"}
    //指定页面
    //{}


    if (defaultTargetPlatform == TargetPlatform.android) {
      extras = json.decode(message['extras']['cn.jpush.android.EXTRA']);
    } else {
      extras = message;
    }
    String url = extras['url'];

    if (url != null) {
      //提交url
//      Routes.navigateTo(context, HomeRouteProvider.webView, params: {
//        'url': url,
//      });
      return;
    }

    String id = extras['id'];
//    String type = extras['type'];
    String intent = extras['intention'];
//    if (intent != null) {
//      switch (intent) {
//        case "video_page": //配音页面
//          Routes.navigateTo(
//              context, LearnParkRouteProvider.advancedVideoPlayPage,params: {
//            'videoId':id,
//          });
//          break;
//        case "article_page": //文章页面
//          Routes.navigateTo(
//              context, HomeRouteProvider.webView,params: {
//            "url": '${ConfigUtil.resourceUrl}/static/e-school.html?id=$id'
//          });
//          break;
//        case "dub_page": //表演页面
//          Routes.navigateTo(
//              context, LearnParkRouteProvider.advancedVideoPlayPage,params: {
//            'videoId':id,
//          });
//          break;
//        case "painted_page": //绘本页面
//          Routes.navigateTo(
//              context, LearnParkRouteProvider.cartoonBookIndex,params: {
//            'book_id':id,
//          });
//          break;
//        case "song_video_page": //儿歌视频页面
//          Routes.navigateTo(
//              context, LearnParkRouteProvider.songVideoPlayPage,params: {
//            "categoryId":id,
//          });
//          break;
//        case "song_audio_page": //儿歌音频页面
//          Routes.navigateTo(
//              context, LearnParkRouteProvider.songPlayPage,params: {
//            "categoryId":id,
//          });
//          break;
//        case "cartoon_page": //动画页面
//          Routes.navigateTo(
//              context, LearnParkRouteProvider.cartoonVideoPlayPage,params: {
//            "categoryId":id,
//          });
//          break;
//      }
//    }
  }
}
