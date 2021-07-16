import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*
  * 请求 操作类
  * 单例模式
  * 手册
  * https://github.com/flutterchina/dio/blob/master/README-ZH.md
  *
*/
class RequestUtil {
  static final String SERVER_API_URL="https://api.zhuishushenqi.com";
  static RequestUtil _instance = RequestUtil._internal();

  factory RequestUtil() => _instance;

  Dio dio;

  RequestUtil._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = new BaseOptions(
      // 请求基地址,可以包含子路径
      baseUrl: SERVER_API_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,

      // Http请求头.
      headers: {},

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    dio = new Dio(options);

    // 添加拦截器
    dio.interceptors.add(HttpLogInterceptor());
    dio.interceptors.add(UserLoginInterceptor());

    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // 在请求被发送之前做一些事情
      return handler.next(options); //continue
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      // 在返回响应数据之前做一些预处理

      return handler.next(response); // continue
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      // 当请求失败时做一些预处理
      return handler.next(e);
      // createErrorEntity(e);
    }));
  }

  /*
   * 获取token
   */
  void setToken(String token) {
    if (token == null) {
      dio.options.headers.remove("token");
      return;
    }
    dio.options.headers = {"token": token};
  }

  /// get 操作
  Future get(
    String path, {
    dynamic params,
    Options options,
  }) async {
    try {
      Options requestOptions = options ?? Options();

      var response = await dio.get(
        path,
        queryParameters: params,
        options: requestOptions,
      );
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  ///  post 操作
  Future post(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.post(path, data: params, options: requestOptions);
    return response.data;
  }

  ///  put 操作
  Future put(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.put(path, data: params, options: requestOptions);
    return response.data;
  }

  ///  put form data 操作
  Future putFormData(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.put(path,
        data: FormData.fromMap(params), options: requestOptions);
    return response.data;
  }

  ///  patch 操作
  Future patch(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.patch(path, data: params, options: requestOptions);
    return response.data;
  }

  /// delete form data操作
  Future deleteFormData(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.delete(path,
        data: FormData.fromMap(params), options: requestOptions);
    return response.data;
  }

  /// delete 操作
  Future delete(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response =
        await dio.delete(path, data: params, options: requestOptions);
    return response.data;
  }

  ///  post form 表单提交操作
  Future postForm(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.post(path,
        data: FormData.fromMap(params), options: requestOptions);
    return response.data;
  }
}

/*
   * error统一处理
   */
// 错误信息
ErrorEntity createErrorEntity(DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:
      {
        return ErrorEntity(code: -1, message: "请求取消");
      }
      break;
    case DioErrorType.connectTimeout:
      {
        return ErrorEntity(code: -1, message: "连接超时");
      }
      break;
    case DioErrorType.sendTimeout:
      {
        return ErrorEntity(code: -1, message: "请求超时");
      }
      break;
    case DioErrorType.receiveTimeout:
      {
        return ErrorEntity(code: -1, message: "响应超时");
      }
      break;
    case DioErrorType.response:
      {
        try {
          int errCode = error.response.statusCode;
          // String errMsg = error.response.statusMessage;
          // return ErrorEntity(code: errCode, message: errMsg);
          switch (errCode) {
            case 400:
              {
                return ErrorEntity(code: errCode, message: "请求语法错误");
              }
              break;
            case 401:
              {
                return ErrorEntity(code: errCode, message: "没有权限");
              }
              break;
            case 403:
              {
                return ErrorEntity(code: errCode, message: "服务器拒绝执行");
              }
              break;
            case 404:
              {
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              }
              break;
            case 405:
              {
                return ErrorEntity(code: errCode, message: "请求方法被禁止");
              }
              break;
            case 500:
              {
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              }
              break;
            case 502:
              {
                return ErrorEntity(code: errCode, message: "无效的请求");
              }
              break;
            case 503:
              {
                return ErrorEntity(code: errCode, message: "服务器挂了");
              }
              break;
            case 505:
              {
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              }
              break;
            default:
              {
                // return ErrorEntity(code: errCode, message: "未知错误");
                return ErrorEntity(
                    code: errCode, message: error.response.statusMessage);
              }
          }
        } on Exception catch (_) {
          return ErrorEntity(code: -1, message: "未知错误");
        }
      }
      break;
    default:
      {
        return ErrorEntity(code: -1, message: error.message);
      }
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int code;
  String message;

  ErrorEntity({this.code, this.message});

  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}

// todo 加密数据解析Interceptor
class DecryptDataInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!response.requestOptions.uri.path.contains("/user/login") &&
        response.data is Map &&
        (response.data as Map).containsKey("code") &&
        response.data["code"] != 200) {
      // 退出登录

      return;
    }
    handler.next(response);
  }
}

// data code status interceptor
class UserLoginInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!response.requestOptions.uri.path.contains("/user/login") &&
        response.data is Map &&
        (response.data as Map).containsKey("code") &&
        response.data["code"] != 200) {
      return handler.reject(DioError(
        requestOptions: response.requestOptions,
        error: response.data,
      ));
      // userProvider.onLogout();
      // MyNavigator.popAllAndPush(LoginPage());
      // return;
    }
    handler.next(response);
  }

}

// log interceptor
class HttpLogInterceptor extends Interceptor {
  DateTime _time;

  HttpLogInterceptor();

  bool get isDebug => !kReleaseMode;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _time = DateTime.now();
    if (isDebug)
      debugPrint("""
----------------------------------
url:    ${options.baseUrl}${options.path}
method: ${options.method}
header: ${options.headers}
params: ${options.method == 'POST' ? options.data is Map ? json.encode(options.data) : options.data : options.queryParameters}
----------------------------------
""");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("""
----------------------------------
time:   ${DateTime.now().millisecondsSinceEpoch - _time.millisecondsSinceEpoch}
url:    ${response.requestOptions.baseUrl}${response.requestOptions.path}
method: ${response.requestOptions.method}
header: ${response.requestOptions.headers}
params: ${response.requestOptions.method == 'POST' ? response.requestOptions.data is Map ? json.encode(response.requestOptions.data) : response.requestOptions.data : response.requestOptions.queryParameters}
status: ${response.statusCode}
resp:   ${response.toString()}
----------------------------------
""");
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // 打印日志
    debugPrint("""
----------------------------------
time:   ${DateTime.now().millisecondsSinceEpoch - _time.millisecondsSinceEpoch}
url:    ${err.requestOptions.baseUrl}${err.requestOptions.path}
method: ${err.requestOptions.method}
header: ${err.requestOptions.headers}
params: ${err.requestOptions.method == 'POST' ? err.requestOptions.data is Map ? json.encode(err.requestOptions.data) : err.requestOptions.data : err.requestOptions.queryParameters}
status: ${err.response?.statusCode ?? ""}
msg:    ${err.toString()}
----------------------------------
""");
    handler.next(err);
  }
}
