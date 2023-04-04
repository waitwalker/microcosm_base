import 'package:dio/dio.dart';
import 'package:microcosm_base/services/network/dio_config.dart';
import 'package:microcosm_base/services/network/http_request_internal.dart';
import 'package:microcosm_base/utils/toast_utils.dart';

typedef Success<T> = Function(T data);
typedef Fail<int, T> = Function(int code, T data);

typedef MicResponseBody<M> = Function(
    Success<M?>? success, dynamic data, bool? h5Req, Fail? fail);

///TODO rewrite
var micResponseBody =
    <M>(Success? success, dynamic data, bool? h5Req, Fail? fail) {};

class MicHttpUtils {
  /// url不包括域名的话使用默认域名
  /// cacheable 缓存
  static Future<void> get<M>(String url,
      {parameters,
      String? contentType = Headers.jsonContentType,
      bool? h5Req,
      Success? success,
      Fail? fail,
      bool? cacheable,
      ProgressCallback? onReceiveProgress}) async {
    request<M>(
      HttpMethod.GET,
      url,
      parameters: parameters,
      h5Req: h5Req,
      contentType: contentType,
      success: success,
      fail: fail,
      cacheable: cacheable,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// url不包括域名的话使用默认域名
  static Future<void> post<M>(String url,
      {body,
      String? contentType = Headers.jsonContentType,
      bool? h5Req,
      Success? success,
      Fail? fail,
      bool? cacheable,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    request<M>(HttpMethod.POST, url,
        parameters: body,
        h5Req: h5Req,
        contentType: contentType,
        success: success,
        fail: fail,
        cacheable: cacheable,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress);
  }

  /// url不包括域名的话使用默认域名
  static void request<M>(HttpMethod method, String url,
      {parameters,
      bool? h5Req,
      String? contentType,
      Success? success,
      Fail? fail,
      bool? cacheable,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) {
    MicHttpRequest.request<M>(method, url,
        params: parameters, contentType: contentType, success: (result) {
      micResponseBody<M>(success, result, h5Req, fail);
    }, fail: (code, error) {
      if (fail != null) {
        fail(code, error);
      } else {
        ToastUtils.toastShort("Request failure ! code:$code msg:$error");
      }
    },
        cacheable: cacheable,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }
}
