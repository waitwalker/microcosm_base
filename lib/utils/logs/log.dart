// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:microcosm_base/utils/logs/pretty_printer.dart';

/// Created by yufengyang on 2022/2/19 9:33 下午
/// @des  Log
/// 前景色            背景色           颜色
// ---------------------------------------
// 30                40              黑色
// 31                 41              红色
// 32                42              绿色
// 33                43              黃色
// 34                44              蓝色
// 35                45              紫红色
// 36                46              青蓝色
// 37                47              白色
///例子：
// \033[1;31;40m    <!--1-高亮显示 31-前景色红色  40-背景色黑色-->
// \033[0m          <!--采用终端默认设置，即取消颜色设置-->

class Log {
  // release环境不会打印
  // static final _dev_logger = Logger(
  //   level: Level.info,
  //   filter: null,
  //   output: microcosm_baseConsoleOutput(),
  //   printer: microcosm_PrettyPrinter(
  //       stackTraceBeginIndex: PlatformUtils.isWeb ? 5 : 4,
  //       //显示最近连续的方法
  //       methodCount: 1,
  //       printTime: true),
  // );

  static final _prod_logger = Logger(
    level: Level.info,
    filter: ProductionFilter(),
    output: _ProdMicrocosmConsoleOutput(),
    printer: MicrocosmPrettyPrinter(
        lineLength: 512,
        // printer: PrettyPrinter(
        //因为包了几层，前面信息不显示
        stackTraceBeginIndex: 4,
        //显示最近连续的方法
        methodCount: 1,
        printTime: true),
  );

  // static var logger = _dev_logger;

  static var logger = _prod_logger;

  static void d(Object msg, [dynamic error, StackTrace? stackTrace]) {
    logger.d(msg, error, stackTrace);
    // _localFileOutput.outputLocalMsg(msg, error, stackTrace);
  }

  static void i(Object msg, [dynamic error, StackTrace? stackTrace]) {
    logger.i(msg, error, stackTrace);
    // _localFileOutput.outputLocalMsg(msg, error, stackTrace);
  }

  static void e(Object msg, [dynamic error, StackTrace? stackTrace]) {
    logger.e(msg, error, stackTrace);
    // _localFileOutput.outputLocalMsg(msg, error, stackTrace);
  }

  static void w(Object msg, [dynamic error, StackTrace? stackTrace]) {
    logger.w(msg, error, stackTrace);
    // _localFileOutput.outputLocalMsg(msg, error, stackTrace);
  }

  /// 原始数据  info
  static void rawI(Object msg) {
    String content = '$msg';
    content.split('\n').forEach((element) {
      _print_color(element, '32');
    });
  }

  ///原始数据 错误
  static void rawE(Object msg) {
    _print_color(msg, '31');
    String content = '$msg';
    content.split('\n').forEach((element) {
      _print_color(element, '32');
    });
  }

  static _print_color(Object msg, String colorValue) {
    // 800 is the size of each chunk
    final pattern = RegExp('.{1,800}');
    // ignore: avoid_print
    pattern.allMatches(msg.toString()).forEach((match) {
      if (!kReleaseMode) {
        debugPrint(
            "\x1B[${colorValue}m com.xianlai.microcosm_base [${DateTime.now().toIso8601String()}]===> ${match.group(0)}\x1B[0m");
      }
    });
  }
}

class _ProdMicrocosmConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final msg = event.lines.join('\n');
    // ignore: avoid_print
    debugPrint(msg);
  }
}
