import 'dart:io';

import 'package:flutter/foundation.dart';

/// Created by yufengyang on 2022/2/28 1:52 下午
/// @des platform

class PlatformUtils {
  static bool get isWeb => kIsWeb;

  ///必须先判断web，在判断其他平台，否则web会报 Unsupported operation: Platform._operatingSystem
  static bool get isAndroid => !isWeb && Platform.isAndroid;

  static bool get isIOS => !isWeb && Platform.isIOS;

  static bool get isMacOS => !isWeb && Platform.isMacOS;

  /// release 模式
  static bool get isRelease => kReleaseMode;

  /// debug
  static bool get isDebug => kDebugMode;

  static String get getPlatform => kIsWeb
      ? "h5"
      : isAndroid
          ? "android"
          : isIOS
              ? "ios"
              : Platform.operatingSystem;

  static int get getClientType => kIsWeb
      ? 3
      : isAndroid
          ? 2
          : isIOS || isMacOS
              ? 1
              : 0;

}
