import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:microcosm_base/configs/channel.dart';
import 'package:microcosm_base/configs/config.dart';
import 'package:microcosm_base/utils/device_info.dart';
import 'package:microcosm_base/utils/package_info.dart';
import 'package:microcosm_base/utils/platform.dart';

/// Created by yufengyang on 2022/2/19 3:09 下午
/// @des dio utils

enum HttpMethod { GET, POST, DELETE, PUT, PATCH, HEAD }

//使用：MethodValues[Method.POST]
const MethodValues = {
  HttpMethod.GET: "GET",
  HttpMethod.POST: "POST",
  HttpMethod.DELETE: "DELETE",
  HttpMethod.PUT: "PUT",
  HttpMethod.PATCH: "PATCH",
  HttpMethod.HEAD: "HEAD",
};

const int ConnectTimeout = 10000;
const int IdleTimeout = 60000;
// 从开始就计时
const int ReceiveTimeout = 15000;
// 每个buf发送成功都会重置计时
const int GetSendTimeout = 15000;
// 每个buf发送成功都会重置计时
const int PostSendTimeout = 60000;

///每次不用变化的数据
Map<String, dynamic> getHeaders() {
  //新增的http2 dio_http2 里 header只支持string类型，否则报错
  Map<String, dynamic> httpHeaders = {
    "x-qp-appid": const String.fromEnvironment("microcosmAppId"),
    "x-qp-appversion": PackageInfoUtils.version,
    "x-qp-resversion": "",
    "x-qp-os": PlatformUtils.getPlatform,
    "x-qp-osversion": '${DeviceInfoUtils.devicesInfoUtils("osVersion")}',
    "x-qp-clienttype": '${PlatformUtils.getClientType}',
    "x-qp-channelid": globalChannel,
    "timezone": '${DateTime.now().timeZoneOffset.inHours}',
    "timezone_offset": '${DateTime.now().timeZoneOffset.inMinutes}',
    "mic-device-id": DeviceInfoUtils.getDeviceId(),
    "user-agent": _getHttpVersion(),
    "accept-encoding": "br,gzip"
  };

  return httpHeaders;
}

int getCurrentTampSecond() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

int numValue = 100000000;

String getNonce() {
  return "${DeviceInfoUtils.devicesInfoUtils(PlatformUtils.isAndroid ? "androidId" : PlatformUtils.isIOS || PlatformUtils.isMacOS ? "identifierForVendor" : PlatformUtils.isWeb ? "vendor" : "")}${getCurrentTampSecond()}${getRandom(numValue)}";
}

///
/// 获取网关header，每次都会变化
Map<String, dynamic> getGatewayDynamicHeaders() {
  Map<String, dynamic> httpHeaders = {
    "x-qp-timestamp": '${getCurrentTampSecond()}',
    "x-qp-nonce": getNonce(),
    "x-qp-locale": locale,
    "mic-shu-mei-device-id": shuMeiDeviceId,
    "x-qp-userid": userId,
    "x-qp-bundleid": PackageInfoUtils.packageName,
    "x-qp-gid": userId
  };

  return httpHeaders;
}

///获取一级渠道ID
String getFirstChannel() {
  String channel = "";
  if (PlatformUtils.isIOS) {
    channel = iosChannel;
  } else if (PlatformUtils.isAndroid) {
    if (ChannelConfig.currentChannel == Channel.googlePlay) {
      channel = androidGooglePlayChannel;
    } else {
      channel = androidChannel;
    }
  } else {
    channel = "";
  }
  return channel;
}

///获取sub渠道ID
String getSubChannel() {
  String channel = "";
  if (PlatformUtils.isIOS) {
    channel = iosSubChannel;
  } else if (PlatformUtils.isAndroid) {
    if (ChannelConfig.currentChannel == Channel.googlePlay) {
      channel = androidGooglePlaySubChannel;
    } else {
      channel = androidSubChannel;
    }
  } else {
    channel = "";
  }
  return channel;
}

//获取sign
String getSign(Uri uri, String method, Map<String, dynamic> headers,
    Map<String, dynamic> data) {
  List<String> headersMap = [];
  // Uri uri = Uri.parse(url);
  //需要完整url地址
  // https://xianlaigame.feishu.cn/wiki/wikcnTgboCD1TTKBOdKOODr1u0f
  //header 只需要这3个
  headersMap.add("X-QP-AppId:${headers['X-QP-AppId']}");
  headersMap.add("X-QP-Nonce:${headers['X-QP-Nonce']}");
  headersMap.add("X-QP-Timestamp:${headers['X-QP-Timestamp']}");

  String headerSign = headersMap.join("");
  //url
  String urlSign = uri.path;

  if (data.isNotEmpty && method != "POST" && method != "PUT") {
    List<String> queryKeys = [];
    data.forEach((key, value) {
      queryKeys.add(key);
    });
    queryKeys.sort();

    List<String> queryArr = [];

    for (var element in queryKeys) {
      if (data[element] != null) {
        queryArr.add("$element=${data[element]}");
      }
    }

    urlSign = "$urlSign?${queryArr.join('&')}";
  }

  String secret = kIsWeb ? microcosmWebSecret : microcosmAppSecret;

  String sign =
      '$method$headerSign${uri.scheme}://${uri.host}${urlSign}$secret';
  sign = generateMd5(sign);
  return sign;
}

String generateMd5(String data) {
  var content = Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  return hex.encode(digest.bytes).toString().toUpperCase();
}

String _getHttpVersion() {
  var version = Platform.version;
  // Only include major and minor version numbers.
  int index = version.indexOf('.', version.indexOf('.') + 1);
  version = version.substring(0, index);
  return 'Dart/$version (dart:io)';
}

int getRandom(int num) {
  return Random().nextInt(num) + 1;
}
