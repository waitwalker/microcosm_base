import 'package:dio_http2_adapter/dio_http2_adapter.dart';

///
/// Created by hai046 on 2023/3/6 17:32.
///

///
typedef MicGetter = String Function();

MicGetter defaultMicGetterGlobalDeviceId = () {
  return '';
};

///TODO 需要实现一下
MicGetter globalChannelGetter = defaultMicGetterGlobalDeviceId;
MicGetter globalDeviceIdGetter = defaultMicGetterGlobalDeviceId;
MicGetter localeGetter = defaultMicGetterGlobalDeviceId;
MicGetter userIdGetter = defaultMicGetterGlobalDeviceId;
MicGetter shuMeiDeviceIdGetter = defaultMicGetterGlobalDeviceId;
MicGetter accessTokenGetter = defaultMicGetterGlobalDeviceId;
SecureDomain2IPManager? secureDomain2Address;

String get globalChannel => globalChannelGetter();
String get globalDeviceId => globalDeviceIdGetter();

String get locale => localeGetter();

String get userId => userIdGetter();

String get shuMeiDeviceId => shuMeiDeviceIdGetter();

String get accessToken => accessTokenGetter();

//下面是直接获取的

const facebookAppId = String.fromEnvironment('facebookAppId');
const facebookClientToken = String.fromEnvironment('facebookClientToken');
const ios_bundle_identifier = String.fromEnvironment('ios_bundle_identifier');
const ios_app_id =
    String.fromEnvironment('ios_app_id'); //iOS端app id（跳转appstore url 拼接那个id）
const appsflyer_initkey =
    String.fromEnvironment('appsflyer_initkey'); //appflyer sdk初始key
const versionName = String.fromEnvironment('versionName');
const versionCode = int.fromEnvironment('versionCode');
const applicationId = String.fromEnvironment('applicationId');
const facebookAndroidClientToken =
    String.fromEnvironment('facebookAndroidClientToken');
const microcosmAppId = int.fromEnvironment('microcosmAppId', defaultValue: 0);
const microcosmAppSecret = String.fromEnvironment('microcosmAppSecret');
const imSdkAppID = int.fromEnvironment('imSdkAppID', defaultValue: 0);
const label = String.fromEnvironment('label');
const schemeHost = String.fromEnvironment('schemeHost');
const scheme = String.fromEnvironment('scheme');
const privacyProtocol = String.fromEnvironment('privacyProtocol');
const teamsOfService = String.fromEnvironment('teamsOfService');
const sourceSdkAppId = int.fromEnvironment('sourceSdkAppId');
const sourceSdkUrl = String.fromEnvironment('sourceSdkUrl');
const microcosmWebSecret = String.fromEnvironment('microcosmWebSecret');
const androidChannel = String.fromEnvironment('androidChannel');
const androidSubChannel = String.fromEnvironment('androidSubChannel');
const iosChannel = String.fromEnvironment('iosChannel');
const iosSubChannel = String.fromEnvironment('iosSubChannel');
const androidGooglePlayChannel =
    String.fromEnvironment('androidGooglePlayChannel');
const androidGooglePlaySubChannel =
    String.fromEnvironment('androidGooglePlaySubChannel');
const adUnitIdAndroid = String.fromEnvironment('adUnitIdAndroid');
const adUnitIdIos = String.fromEnvironment('adUnitIdIos');
const environment = String.fromEnvironment('environment');
const imGoogleFCMPushBuzID = int.fromEnvironment('imGoogleFCMPushBuzID');
const topOnAndroidAdAppId = String.fromEnvironment('topOnAndroidAdAppId');
const topOnAndroidAdAppKey = String.fromEnvironment('topOnAndroidAdAppKey');
const topOnAndroidRewardVideoAdPlacementId =
    String.fromEnvironment('topOnAndroidRewardVideoAdPlacementId');
const topOnAndroidInsertAdPlacementId =
    String.fromEnvironment("topOnAndroidInsertAdPlacementId");
const topOnIosAdAppId = String.fromEnvironment('topOnIosAdAppId');
const topOnIosAdAppKey = String.fromEnvironment('topOnIosAdAppKey');
const topOnIosRewardVideoAdPlacementId =
    String.fromEnvironment('topOnIosRewardVideoAdPlacementId');
const topOnIosInsertAdPlacementId =
    String.fromEnvironment("topOnIosInsertAdPlacementId");
