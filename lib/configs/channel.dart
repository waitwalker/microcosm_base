/// created by yufengyang on 2022/5/19 16:52
///des

enum Channel { googlePlay, normal }

class ChannelConfig {
  static String channel = "normal";

  ///获取当前渠道
  static Channel get currentChannel {
    switch (channel) {
      case "normal":
        return Channel.normal;
      case "googlePlay":
        return Channel.googlePlay;
      default:
        return Channel.normal;
    }
  }
}
