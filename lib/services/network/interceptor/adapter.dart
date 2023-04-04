import 'package:microcosm_base/utils/platform.dart';

/// created by yufengyang on 2022/9/5 10:31
///des adapter  处理 http2adapter findProxy

class Adapter {
  static Map<String, String>? proxyHttp;
  static final bool _canProxy =
      !PlatformUtils.isWeb && !PlatformUtils.isRelease && proxyHttp != null;

  /// method_name onClientCreate
  /// description 获取  onClientCreate
  /// @param []
  ///#return
  static onClientCreate() {
    if (_canProxy == true) {
      return _onBadCertificate;
    }
    return _onBadCertificateNoProxy;
  }

  /// method_name onBadCertificate
  /// description 支持http2 抓包
  /// @param [_, config]
  ///#return
  static _onBadCertificate(_, config) {
    return config
      ..onBadCertificate = ((cer) => true)
      ..proxy = _canProxy == true
          ? Uri.http('${proxyHttp?['host']}:${proxyHttp?['port']}', '')
          : null;
  }

  ///无代理 默认走系统默认；
  static _onBadCertificateNoProxy(_, config) {
    // return config..onBadCertificate = ((cer) => true);
    return null;
  }
}
