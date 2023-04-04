import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

///state的生命周期状态，后续需要其他再继续添加
enum StateLifeEvent {
  ///实例化
  created,

  ///初始化
  init,

  ///销毁
  dispose
}

///监听State的dispose,自动销毁一些东西
mixin StateLifecycleMixin<T extends StatefulWidget> on State<T>
    implements ValueListenable<StateLifeEvent> {
  final ValueNotifier<StateLifeEvent> _lifeEventNotifier =
      ValueNotifier(StateLifeEvent.created);

  @override
  StateLifeEvent get value => _lifeEventNotifier.value;

  @override
  void addListener(void Function() function) {
    //分发当前的状态
    function.call();
    if (_lifeEventNotifier.value == StateLifeEvent.dispose) {
      return;
    }
    _lifeEventNotifier.addListener(function);
  }

  @override
  void removeListener(void Function() function) {
    _lifeEventNotifier.removeListener(function);
  }

  @override
  void initState() {
    super.initState();
    _lifeEventNotifier.value = StateLifeEvent.init;
  }

  @override
  void dispose() {
    super.dispose();
    _lifeEventNotifier.value = StateLifeEvent.dispose;
    _lifeEventNotifier.dispose();
  }
}
