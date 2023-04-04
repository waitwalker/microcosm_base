import 'package:flutter/foundation.dart';
import 'package:microcosm_base/utils/toast_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Created by yufengyang on 2022/2/28 3:08 下午
/// @des packageinfo

class PackageInfoUtils {
  static PackageInfo _packageInfo = PackageInfo(
      appName: "",
      packageName: "",
      version: "",
      buildNumber: "",
      buildSignature: "");

  static Future init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static String get appName => _packageInfo.appName;

  static String get packageName => getPackage();

  static String get version =>const String.fromEnvironment('versionName');

  static String get buildNumber => _packageInfo.buildNumber;

  static String get buildSignature => _packageInfo.buildSignature;

  static String getPackage() {
    if (!kReleaseMode) {
      //如果不是release模式，打包时候可以伪造flutter层包名
      //例如在更新时候就用传递的包名，可以让他们自己决定更新包
      String packageSuffix = const String.fromEnvironment("aliasPackageName");
      if (packageSuffix.isNotEmpty) {
        ToastUtils.toastLong('Flutter api层自定义包名是：$packageSuffix');
        return packageSuffix;
      }
    }
    return _packageInfo.packageName;
  }
}
