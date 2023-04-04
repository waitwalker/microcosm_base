import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:microcosm_base/utils/lifecycle/lifecycle_extension.dart';
import 'package:microcosm_base/utils/lifecycle/state_lifecycle_mixin.dart';

class ConnectManager {
  static ConnectManager? _instance;

  factory ConnectManager() {
    _instance ??= ConnectManager._internal();
    return _instance!;
  }

  final ValueNotifier<ConnectivityResult> _connectNotifier =
      ValueNotifier(ConnectivityResult.wifi);

  ConnectManager._internal() {
    Connectivity().onConnectivityChanged.listen((event) {
      _connectNotifier.value = event;
    });
    _initConnection();
  }

  void _initConnection() async {
    _connectNotifier.value = await Connectivity().checkConnectivity();
  }

  ///获取当前的网络状态
  ConnectivityResult get connectState => _connectNotifier.value;

  ///添加网络状态监听，如果不传[lifecycle],记得移除see[removeConnectChangeListener]
  ///[listener] 网络状态变化监听，需要再次调用[connectState]获取变化后的状态
  ///[lifecycle] dispose自动移除监听,see[StateLifecycleMixin
  void addConnectChangeListener(void Function() listener,
      {ValueListenable<StateLifeEvent>? lifecycle, firstCallback = true}) {
    if (firstCallback) {
      listener.call();
    }
    if (lifecycle != null) {
      _connectNotifier.addListenerOn(lifecycle, listener);
    } else {
      _connectNotifier.addListener(listener);
    }
  }

  ///移除监听
  void removeConnectChangeListener(void Function() listener) {
    _connectNotifier.removeListener(listener);
  }
}
