/// Created by yufengyang on 2022/3/4 5:09 下午
/// @des 代理
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:microcosm_base/utils/platform.dart';
import 'package:system_proxy/system_proxy.dart';

class InterceptorProxy extends Interceptor {
  final Dio? _dio;

  static Map<String, String>? _proxy;

  InterceptorProxy(this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!PlatformUtils.isWeb && !PlatformUtils.isRelease) {
      //fix web Error: Unsupported operation: Platform._operatingSystem
      _proxy = await SystemProxy.getProxySettings();
      if (_proxy != null &&
          _dio?.httpClientAdapter is DefaultHttpClientAdapter) {
        //TODO  正式的话废弃掉
        (_dio?.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          client.badCertificateCallback =
              (cert, host, port) => Platform.isAndroid;
          client.findProxy =
              (uri) => "PROXY ${_proxy?['host']}:${_proxy?['port']}";
          //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return null;
        };
      }
    }
    super.onRequest(options, handler);
  }
}
