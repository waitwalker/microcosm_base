import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:microcosm_base/configs/config.dart';
import 'package:microcosm_base/utils/logs/log.dart';
import 'package:microcosm_base/utils/platform.dart';
import 'package:microcosm_base/utils/toast_utils.dart';

/// Created by yufengyang on 2022/2/28 2:06 下午
/// @des deviceinfo

class DeviceInfoUtils {
  static Map<String, dynamic> _deviceInfo = {};

  static Future init() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (PlatformUtils.isWeb) {
      await deviceInfoPlugin.webBrowserInfo.then((data) {
        _deviceInfo = {
          'browserName': describeEnum(data.browserName),
          'appCodeName': data.appCodeName,
          'appName': data.appName,
          'osVersion': data.appVersion,
          'deviceMemory': data.deviceMemory,
          'language': data.language,
          'languages': data.languages,
          'platform': data.platform,
          'product': data.product,
          'productSub': data.productSub,
          'userAgent': data.userAgent,
          'vendor': data.vendor,
          'vendorSub': data.vendorSub,
          'hardwareConcurrency': data.hardwareConcurrency,
          'maxTouchPoints': data.maxTouchPoints,
        };
      });
    } else if (PlatformUtils.isAndroid) {
      await deviceInfoPlugin.androidInfo.then((build) {
        _deviceInfo = {
          'version.securityPatch': build.version.securityPatch,
          'version.sdkInt': build.version.sdkInt,
          'osVersion': build.version.release,
          'version.previewSdkInt': build.version.previewSdkInt,
          'version.incremental': build.version.incremental,
          'version.codename': build.version.codename,
          'version.baseOS': build.version.baseOS,
          'board': build.board,
          'bootloader': build.bootloader,
          'brand': build.brand,
          'device': build.device,
          'display': build.display,
          'fingerprint': build.fingerprint,
          'hardware': build.hardware,
          'host': build.host,
          'id': build.id,
          'manufacturer': build.manufacturer,
          'model': build.model,
          'product': build.product,
          'supported32BitAbis': build.supported32BitAbis,
          'supported64BitAbis': build.supported64BitAbis,
          'supportedAbis': build.supportedAbis,
          'tags': build.tags,
          'type': build.type,
          'isPhysicalDevice': build.isPhysicalDevice,
          'androidId': build.androidId,
          'systemFeatures': build.systemFeatures,
        };
        Log.i("设备信息===>${_deviceInfo.toString()}");
      });
    } else if (PlatformUtils.isIOS) {
      await deviceInfoPlugin.iosInfo.then((data) {
        _deviceInfo = {
          'name': data.name,
          'systemName': data.systemName,
          'osVersion': data.systemVersion,
          'model': data.model,
          'localizedModel': data.localizedModel,
          'identifierForVendor': data.identifierForVendor,
          'isPhysicalDevice': data.isPhysicalDevice,
          'utsname.sysname:': data.utsname.sysname,
          'utsname.nodename:': data.utsname.nodename,
          'utsname.release:': data.utsname.release,
          'utsname.version:': data.utsname.version,
          'utsname.machine:': data.utsname.machine,
        };
      });
    } else {
      ToastUtils.toastShort("unKnown error");
    }

    Log.rawI("deviceInfo===>${_deviceInfo}");
  }

  //获取设备信息 deviceKey 要获取某一个信息的key;
  static devicesInfoUtils(String deviceKey) {
    if (_deviceInfo.containsKey(deviceKey)) {
      return _deviceInfo[deviceKey];
    }
    return "";
  }

  static String getDeviceId() {
    var deviceId = "";
    if ((PlatformUtils.isAndroid || PlatformUtils.isIOS)) {
      deviceId = globalDeviceId;
    } else {
      deviceId = "";
    }

    if (deviceId.isEmpty) {
      return devicesInfoUtils(PlatformUtils.isAndroid
          ? "androidId"
          : PlatformUtils.isIOS
              ? "identifierForVendor"
              : PlatformUtils.isWeb
                  ? ""
                  : "");
    } else {
      return deviceId;
    }
  }

  static String getBrand() {
    return devicesInfoUtils(PlatformUtils.isAndroid
        ? "model"
        : PlatformUtils.isIOS
            ? "utsname.machine:"
            : PlatformUtils.isWeb
                ? ""
                : "");
  }
}
