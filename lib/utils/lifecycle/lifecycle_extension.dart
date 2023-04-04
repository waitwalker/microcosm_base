import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:microcosm_base/utils/lifecycle/state_lifecycle_mixin.dart';

extension AnimationControllerLifecycleExt on AnimationController {
  ///自动dispose动画
  ///[lifecycle] see [StateLifecycleMixin]
  void attachLifecycle(ValueListenable<StateLifeEvent> lifecycle) {
    lifecycle.addAutoRemoveListener(() {
      if (lifecycle.value == StateLifeEvent.dispose) {
        dispose();
      }
    });
  }
}

extension StateLifeEventListenerExt on ValueListenable<StateLifeEvent> {
  ///扩展加在[ValueListenable]上，防止其他实现没有在dispose时清空
  ///[StateLifecycleMixin]dispose时会自动移除所有的listener
  void addAutoRemoveListener(VoidCallback listener) {
    if (value == StateLifeEvent.dispose) {
      listener.call();
    } else {
      void _innerListener() {
        listener.call();
        if (value == StateLifeEvent.dispose) {
          removeListener(_innerListener);
        }
      }

      addListener(_innerListener);
    }
  }
}

extension ListenableLifecycleExt on Listenable {
  ///添加监听，绑定到[lifecycle]自动取消监听
  ///see [StateLifecycleMixin]
  void addListenerOn(
      ValueListenable<StateLifeEvent> lifecycle, VoidCallback listener) {
    addListener(listener);
    lifecycle.addAutoRemoveListener(() {
      if (lifecycle.value == StateLifeEvent.dispose) {
        removeListener(listener);
      }
    });
  }
}

extension StreamLifecycleExt<T> on Stream<T> {
  ///Stream自动取消监听
  ///[lifecycle] see [StateLifecycleMixin]
  StreamSubscription<T> listenOn(
      ValueListenable<StateLifeEvent> lifecycle, void Function(T event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    StreamSubscription<T> subscription = listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    lifecycle.addAutoRemoveListener(() {
      if (lifecycle.value == StateLifeEvent.dispose) {
        subscription.cancel();
      }
    });

    return subscription;
  }
}
