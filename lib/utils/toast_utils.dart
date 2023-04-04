import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// Created by yufengyang on 2022/2/26 2:17 下午
/// @des  toast
///
const KMilliseconds1000 = 1000;
const KMilliseconds3000 = 3000;

class ToastUtils {
  static bool mToastState = false;
  static String mToastMessage = "";

  static toastShort(String message,
      {AlignmentGeometry? alignment, Color? color}) async {
    if (message.isEmpty) {
      return;
    }
    if (mToastMessage == message && mToastState) {
      return;
    }
    mToastMessage = message;
    setDuration();
    SmartDialog.showToast(message,
        displayTime: const Duration(milliseconds: KMilliseconds3000),
        maskColor: color,
        builder: (ctx) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: color ?? Colors.black38,
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
        alignment: alignment ?? Alignment.center);
    mToastState = true;
  }

  static toastShortForLogin(
    String message,
  ) {
    toastShort(message);
  }

  static toastShortCreateTable(
    String message,
  ) {
    toastShort(message);
  }

  static toastShortForHallReward(
    String message,
  ) {
    toastShort(message);
  }

  static toastLong(String message,
      {Alignment? alignment,
      int? count,
      Color? color = const Color.fromRGBO(55, 55, 55, 0.7),
      Color? textColor,
      double? textSize}) {
    SmartDialog.showToast(message,
        displayTime: Duration(milliseconds: KMilliseconds3000),
        maskColor: color,
        builder: (ctx) => Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: color ?? Colors.black38,
              ),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
        alignment: alignment ?? Alignment.center);
  }

  static toastClear() {
    SmartDialog.dismiss(status: SmartStatus.allToast);
  }

  static Timer? timer;

  /// method_name setDuration
  /// description 设置定时置状态
  /// @param
  ///#return
  static setDuration() {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: KMilliseconds3000), () {
      mToastState = false;
    });
  }
}
