import 'package:microcosm_base/services/network/http_utils.dart';

///
/// Created by hai046 on 2023/3/6 17:47.
///
typedef CacheRead = Function(String urlWithoutQueries, Success? success);
typedef CacheWrite<T> = Function(String urlWithoutQueries, T success);

CacheRead dioCacheRead = (String urlWithoutQueries, Success? success) {};
CacheWrite dioCacheWrite = <T>(String urlWithoutQueries, T success) {};

class ApiCache {
  static void writeData<T>(String urlWithoutQueries, T data) {
    dioCacheWrite(urlWithoutQueries, data);
  }

  static void readCache(String urlWithoutQueries, Success? success) {
    dioCacheRead(urlWithoutQueries, success);
  }
}
