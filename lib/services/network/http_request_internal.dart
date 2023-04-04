import 'dart:async';
import 'dart:convert';

import 'package:archive/archive_io.dart';
import 'package:brotli/brotli.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:microcosm_base/configs/config.dart';
import 'package:microcosm_base/services/network/api.dart';
import 'package:microcosm_base/services/network/cache.dart';
import 'package:microcosm_base/services/network/connect_manager.dart';
import 'package:microcosm_base/services/network/dio_config.dart';
import 'package:microcosm_base/services/network/http_utils.dart';
import 'package:microcosm_base/services/network/interceptor/adapter.dart';
import 'package:microcosm_base/services/network/interceptor/interceptor_proxy.dart';
import 'package:microcosm_base/utils/logs/log.dart';
import 'package:microcosm_base/utils/platform.dart';


/// Created by yufengyang on 2022/2/18 5:54 下午
/// @des request

class MicHttpRequest {
  static final MicHttpRequest _instance = MicHttpRequest._internal();

  factory MicHttpRequest() => _instance;

  static late Dio _dio;

  MicHttpRequest._internal() {
    BaseOptions options = BaseOptions(
        connectTimeout: ConnectTimeout,
        headers: getHeaders(),
        receiveTimeout: ReceiveTimeout);
    options.baseUrl = BaseUrl.baseUrl;

    _dio = Dio(options);
    if (!PlatformUtils.isWeb) {
      GZipDecoder gZipDecoder = GZipDecoder();
      BrotliCodec brotliCodec = BrotliCodec();
      //如果是http/2需要自己解析gzip
      options.responseDecoder = (List<int> responseBytes,
          RequestOptions options, ResponseBody responseBody) {
        var contentEncoding =
            '${responseBody.headers['content-encoding']?.first}';
        switch (contentEncoding) {
          case "gzip":
            responseBytes =
                gZipDecoder.decodeBytes(responseBytes, verify: true);
            break;
          case "br":
            responseBytes = brotliCodec.decode(responseBytes);
            break;
        }

        return utf8.decode(responseBytes, allowMalformed: true);
      };
      _dio.httpClientAdapter = Http2Adapter(ConnectionManager(
        idleTimeout: IdleTimeout,
        // Ignore bad certificate
        onClientCreate: Adapter.onClientCreate(),
        secureDomain2Address: secureDomain2Address,
      ));
    }
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers["x-qp-signature"] = getSign(options.uri, options.method,
          options.headers, options.queryParameters);

      var token = accessToken;
      if (token.isNotEmpty) {
        options.headers["x-qp-token"] = token;
      }
      return handler.next(options);
    }));
    _dio.interceptors.add(LogInterceptor(
        requestHeader: true, responseHeader: true, logPrint: Log.d));
    _dio.interceptors.add(InterceptorProxy(_dio));
  }

  static Future request<T>(HttpMethod method, String urlWithoutQueries,
      {dynamic params,
      String? contentType,
      Success? success,
      Fail? fail,
      bool? cacheable,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      cacheable = method == HttpMethod.GET &&
          success != null &&
          cacheable == true &&
          !PlatformUtils.isWeb;
      if (cacheable == true) {
        ApiCache.readCache(urlWithoutQueries, success);
      }
      if (ConnectManager().connectState == ConnectivityResult.none) {
        //网络异常处理方法待定
        if (fail != null) {
          fail(ErrorCode.NETWORK_UNREACHABLE, 'networkDisconnected');
        }
        return;
      }
      dynamic data;
      dynamic queryParameters;
      Log.i("http request params:$params");
      var options = Options(
          method: MethodValues[method],
          headers: getGatewayDynamicHeaders(),
          contentType: contentType);
      if (method == HttpMethod.GET) {
        queryParameters = params;
        options.sendTimeout = GetSendTimeout;
      }
      if (method == HttpMethod.POST) {
        data = params;
        options.sendTimeout = PostSendTimeout;
      }
      var request = _dio.request(urlWithoutQueries,
          data: data,
          queryParameters: queryParameters,
          options: options,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);
      request.then((response) {
        var responseData = response.data;
        if (success != null) {
          // Log.i("request url $urlWithoutQueries");
          success(responseData);
          if (cacheable == true) {
            ApiCache.writeData(urlWithoutQueries, response.data);
          }
        } else {
          //不处理返回
          Log.i(response.toString());
        }
      }).onError<DioError>((error, stackTrace) {
        Log.i("request url $urlWithoutQueries");
        Log.e("request err ", error, stackTrace);
        micFormatError(fail: fail, e: error);
      });
    } on DioError catch (e) {
      //后续处理错误逻辑
      Log.e(e);
      micFormatError(fail: fail, e: e);
    }
  }

  static Dio get dio => _dio;
}

typedef MicFormatError = Function({Fail? fail, required DioError e});

///TODO 需要实现一下
MicFormatError micFormatError = ({Fail? fail, required DioError e}) {};
