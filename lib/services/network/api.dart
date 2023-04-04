/// Created by yufengyang on 2022/2/17 3:59 下午
/// @des 接口api

enum Env {
  ///线上环境
  Prod,

  ///测试环境
  Test,

  ///开发
  Dev,

  ///预发布
  Pre
}

class Config {
  static Env env = Env.Test;

  /// 基础应用服务
  static String get apiHost {
    return const String.fromEnvironment("apiHost");
  }

  /// 策略更新服务
  static String get unityStrategyHost {
    return const String.fromEnvironment("unityStrategyHost");
  }

  ///web url 服务
  static String get webHost {
    return const String.fromEnvironment("webHost");
  }
}

class BaseUrl {
  static String baseUrl = Config.apiHost;
  static String updateUrl = Config.unityStrategyHost;
  static String webUrl = Config.webHost;
}

///所有的api 接口都放在这，便于统一管理
class Api {
  //发送短信验证码
  static const loginSms = "/api/login/sms";

  static const events = "/events";

  //登录用户中心-测试数据
  static const mockRequest = "/uc/v1/login/local";

  static const guestLogin = "/mcaccount/v1/login/guest";

  static const emailLogin = "/mcaccount/v1/login/email";
  static const emailRegister = "/mcaccount/v1/register/email";
  static const emailVerifyCode = "/mcaccount/v1/verifycode/email";
  static const emailForgotPasswd = "/mcaccount/v1/forgotpasswd/email";
  static const loginFacebook = "/mcaccount/v1/login/facebook";
  static const guestLoginV2 = "/mcaccount/v2/login/guest"; //游客登录
  static const tokenRefresh = "/mcaccount/v1/refresh/token";
  static const authToken = "/mcaccount/v1/authentication";
  static const inviteCodeBinding = "/mcactivity/v1/invitecode/register";
  static const bindFacebook = "/mcaccount/v1/bind/facebook";
  static const bindEmail = "/mcaccount/v1/bind/email";
  static const emailSafeLogin = "/mcaccount/v1/safelogin/email";
  static const shareConfig = "/mcactivity/v1/invitecode/share";
  static const shareConfigNew = "/mcactivity/v1/invitecode/shareByScene";
  static const shareEveryday = "/mcactivity/v1/popup/everydayshare";
  static const shareEverydayReward = "/mcactivity/v1/popup/everydaysharereward";
  static const kvConfig = "/psconfig/v1/kv";
  static const kvConfigs = "/psconfig/v1/kvs";

  ///修改个人头像
  static const uploadAvatar = "/mcaccount/v1/upload/headimg";
  static const uploadPhotos = "/mcaccount/v1/upload/photos";
  static const personalInfo = "/mcaccount/v1/homepage";
  static const deletePhoto = "/mcaccount/v1/photo/delete";
  static const dragPhoto = "/mcaccount/v1/photo/drag";
  static const profileEdit = "/mcaccount/v1/profile/edit";
  static const inviteCodeCommon = "/mcactivity/v1/invitecode/common";

  ///上传图片获取图片地址 1.3 ++
  static const uploadImage = "/mcaccount/v1/upload/img";

  ///获取基本信息
  static const baseinfo = "/mcaccount/v1/baseinfo";
  static const getUserAssetsInfo = "/mcasset/v1/asset/user";
  static const like = "/mcaccount/v1/like/give";

  ///时段奖励领取
  static const getClockReward = "/mcactivity/v1/clock/reward";

  ///看广告领取更多奖励查询 - 返回要查看广告视频id 1.2++  rewardId - 业务场景id，产品给客户端写死 2001  serialNo - 领取奖励服务端下发
  static const getVideoAdRewardInfo = "/mcreward/v1/extra/reward/info/adv";

  ///获取领取奖励详情 1.2++
  static const getAdRewardDetail = "/mcreward/v1/extra/reward/adv";

  ///时段奖励状态获取
  static const getClockRewardStates = "/mcactivity/v1/clock/info";

  /// 模块入口 根据参数请求不同模块数据：1：首页大厅；2：我的
  static const modulePortal = "/mcportal/v1/modules";

  /// 批量获取模块配置整合接口 v1.4.0 ++
  static const modules = "/mcportal/v1/modules/batch";

  /// 获取新人礼包&新人引领信息
  static const newPersonGuidanceInfo = "/mcactivity/v1/newbie/reward/info";

  /// 领取新人礼包
  static const newPersonGuidanceReward = "/mcactivity/v1/newbie/reward";

  ///钱包流水
  static const getWalletRecord = "/mcasset/v1/asset/history";

  /// 游戏记录
  static const getGameRecord = "/mcrecord/v1/recordlist";

  /// 商城信息
  static const getStoreInfo = "/mcmall/v1/mall/info";

  /// 购买
  static const buyGoods = "/mcmall/v1/mall/buy";

  /// 提现
  static const withdrawGoods = "/mcmall/v1/mall/payout";

  /// 充值
  static const rechargeGoods = "/mcmall/v1/mall/charge";

  /// 充值结果查询
  static const recharegeCheck = "/mcmall/v1/mall/charge/check";

  /// 绑定pagsmile
  static const bindPagsmile = "/mcmall/v1/mall/bind/pagsmile";

  /// 检查pagsmile
  static const checkPagsmile = "/mcmall/v1/wallet/info";

  /// 绑定pix
  static const bindPix = "/mcmall/v1/mall/bind/pix";

  /// 绑定pix
  static const bindTodayPay = "/mcmall/v1/mall/bind/tdaypay";

  /// 订单列表
  static const orders = "/mcmall/v1/mall/history";

  ///检查游戏更新
  static String checkUnityUpdate = '${BaseUrl.updateUrl}/strategy/v1/game';

  ///访客聊表
  static String visitors = "/mcaccount/v1/visitors";

  ///点赞列表
  static String likes = "/mcaccount/v1/likes";

  ///h5 任务url
  static String h5Task = "${BaseUrl.webUrl}/embed/task/taskIndex";

  ///关注
  static String follow = "/mcchat/v1/follow/user";

  ///创建群聊
  static String createChatGroup = "/mcchat/v1/group";

  ///搜索用户Id
  static String search = "/mcchat/v1/search/user";

  ///粉丝列表
  static String fanList = "/mcchat/v1/fans";

  static String h5Invite = "${BaseUrl.webUrl}/embed/invitation/InvitationIndex";
  static String helpCenter =
      "https://xianlaigame.aihelp.net/webchat/#/appKey/XIANLAIGAME_app_73913653834b4ec7b5566aa7c939eae2/domain/xianlaigame.aihelp.net/appId/xianlaigame_platform_cd061a532b06ac8583b54c91bcfff7e0/?appName=FESP&sdkVersion=2.0.0&mode=showFAQSection&sectionId=64025&showConversationMoment=3&conversationIntent=2";

  ///h5 邀请
  static String h5BingCode =
      "${BaseUrl.webUrl}/embed/invitation/InvitationBindCode";

  ///获取与他人的关系
  static String getRelationWithOther = "/mcchat/v1/user/relation";

  /// 进入游戏
  static const enterGame = "/mcstat/v1/game/enter";

  /// 离开游戏
  static const leaveGame = "/mcstat/v1/game/leave";

  /// 查询任务标签红点数量
  static const bonusTabCount = "/mcportal/v1/page/taskclick";

  /// Club
  /// club通用配置
  static const clubCommonConfig = "/mcclub/v1/config";

  /// club搜索
  static const clubSearch = "/mcclub/v1/search";

  /// 申请club加入
  static const clubJoin = "/mcclub/v1/join";

  /// club列表
  static const clubList = "/mcclub/v1/list";

  /// club详情
  static const clubInfo = "/mcclub/v1/info";

  /// club创建
  static const clubCreation = "/mcclub/v1/create";

  /// 创建club校验
  static const checkCreation = "/mcclub/v1/check/create";

  /// 加入club校验
  static const checkJoin = "/mcclub/v1/check/join";

  /// club编辑
  static const clubEdit = "/mcclub/v1/edit";

  /// club大厅详情
  static const clubHall = "/mcclub/v1/hall";

  /// 退出club
  static const clubExit = "/mcclub/v1/member/exit";

  /// 加入游戏
  static const joinDesk = "/mcfriendgame/v1/joindesk";

  /// 牌桌列表
  static const cardTableList = "/mcclub/v1/desk/list";

  /// 成员离线
  static const memberOffline = "/mcclub/v1/member/offline";

  /// 上传club头像
  static const uploadClubCover = "/mcclub/v1/upload/cover";

  ///club创建牌桌
  static const clubCreateDesk = "/mcfriendgame/v1/createdesk";

  /// 入口开关
  static const switches = "/mcportal/v1/switches";

  /// 推荐好友
  static const recommendFriend = "/mcchat/v1/recommend/friend";

  /// 红包券回收接受
  static const askAccept = "/mcaccount/v1/vip/ask/accept";

  /// 红包券回收拒绝
  static const askRefuse = "/mcaccount/v1/vip/ask/reject";

  /// 绿包券发送接受
  static const giveAccept = "/mcaccount/v1/vip/give/accept";

  /// 订单详情中钱包url
  static const walletUrl = "https://wallet.pagsmile.com/?close";

  /// 成员列表
  static const clubMember = "/mcclub/v1/members";

  /// 查看成员角色
  static const memberRole = "/mcclub/v1/member/role";

  /// 成员详情
  static const clubMemberDetail = "/mcclub/v1/member/info";

  /// 成员积分 v1.4.0 ++
  static const clubMemberScore = "/mcclub/v1/member/asset";

  ///成员退出
  static const memberExit = "/mcclub/v1/member/exit";

  ///工会解散
  static const clubDisband = "/mcclub/v1/disband";

  ///俱乐部消息
  static const clubMsg = "/mcclub/v1/msg";

  /// 删除成员
  static const clubMemberDelete = "/mcclub/v1/member/delete";

  /// 成员积分提交 v1.4.0 ++
  static const clubMemberScoreCommit = "/mcclub/v1/member/change/points";

  /// 红包绿包券搜索 - 1.2 ++
  static const clubRedAndGreenCouponsConditionsSearch =
      "/mcclub/v1/asset/records";

  ///处理加入club 申请
  static const applyJoinRequest = "/mcclub/v1/member/apply";

  ///变更成员角色
  static const changeMemberRole = "/mcclub/v1/member/change/role";

  ///检查是否可以创建群组
  static const checkIsCanCreateGroup = "/mcchat/v1/check/group";

  ///fcm
  static const fcmToke = "/mcpush/v1/fcm/token";

  ///变更club 资产
  static const changeAsset = "/mcclub/v1/change/asset";

  ///查询用户是否在俱乐部
  static const queryUserIsInClub = "/mcclub/v1/member/inclub";

  ///检测是否恢复游戏
  static const queryGameStatus = '/mcfriendgame/v1/querystatus';

  ///appflyer上报设备id等信息  1.2++
  static const appflyeReportStatisticID = '/mcstat/v1/appsflyer/user';

  ///邀请达到条件后，获取自动建群的弹窗信息
  static const fetchInviteGroupDialogInfo = "/mcactivity/v1/invitegroup/popup";

  ///邀请达到条件后,建群或者邀请加入
  static const inviteToGroup = "/mcactivity/v1/invitegroup/addUsers";

  ///QA关键字匹配
  static const qaMatch = "/mcchat/v1/qa/match";

  ///首页跑马灯列表数据
  static const marqueeList = "/mcmall/v1/mall/last/payout";

  /// App更新 v1.4.0 ++
  static const appUpdate = "/mcportal/v1/version/app";

  /// 加密编码token
  static const encryptionCode = "/mcaccount/v1/share/code";

  /// 俱乐部税率设置列表
  static const clubTaxRateSettingsList = "/mcclub/v1/taxrate/list";

  /// 俱乐部税率设置
  static const clubTaxRateSet = "/mcclub/v1/taxrate/save";

  /// 每日翻牌 v1.5.0 ++
  static const dailyTurnOver = "/mcactivity/v1/openpoker/info";

  ///认证角色列表
  static const certRoles = "/mcaccount/v1/cert/roles";

  ///道具资源列表
  static const propList = "/mcitem/v1/template/list";

  ///广告打点
  static const adState = "/stat/index";

  ///查询用户是否属于某用户策略
  static const userEval = "/mcstat/v1/user/evaluate";

  /// 月卡权益信息
  static const monthCardRightsInfo = "/mcitem/v1/right/card/detail";

  /// 立即体验月卡
  static const experienceMonthCardNow = "/mcitem/v1/right/card/exp";

  /// 领取月卡权益
  static const monthCardRightDraw = "/mcitem/v1/right/get";

  /// 获取引导评价弹窗信息 v1.6.5 ++
  static const evaluateGuideInfo = "/mcportal/v1/evaluate/guide/info";

  /// 提交评价信息 v1.6.5 ++
  static const doEvaluate = "/mcportal/v1/evaluate/add";

  ///获取广告流量分组
  static const adGroup = "/mcstat/v1/ad/traffic/group";

  /// 获取分享资产配置信息 v1.8.0 ++
  static const shareAssetConfig = "/mcactivity/v2/popup/everydayshare";

  /// 获取分享奖励配置信息 v1.8.0 ++
  static const shareRewardConfig = "/mcactivity/v2/popup/everydaysharereward";

  /// 是否有权限查看chat群成员信息
  static const checkMemberInfoPermission =
      "/mcclub/v1/check/member/info/permission";

  /// 充值加赠信息详情(DailyBonus/BackBonus)
  static const chargeBonusInfo = "/mcmall/v1/bonus/detail";

  /// 领取DailyBonus
  static const getDailyBonus = "/mcmall/v1/bonus/gain";

  /// 获取俱乐部推荐&代理人推荐弹窗信息 v1.8.0 ++
  static const clubPopup = "/mcclub/v1/popup/recommend";

  /// 获取俱乐部推荐&代理人推荐弹窗展示上报 v1.8.0 ++
  static const clubPopupShow = "/mcclub/v1/record/popup/show";

  /// 获取奖励信息（根据业务奖励rewardId）
  static const getRewardInfo = "/mcreward/v1/info";

  /// 领取奖励（根据业务奖励rewardId）
  static const getReward = "/mcreward/v1/reward";

  ///IM消息撤销
  static const msgRevoke = "/mcchat/v1/group/msg/recall";

  ///通过服务器修改群聊消息
  static const modifyGroupMsgByServer = "/mcchat/v1/group/msg/modify";

  ///充值加赠小红点
  static const bonusRedDot = "/mcmall/v1/bonus/reddot";

  ///VIP
  static const vipDetail = "/mcmall/v1/vip/detail";

  ///Vip每日礼包领取
  static const vipGiftGain = "/mcmall/v1/vip/gift/gain";
}

///负数为客户端自定义异常，0 为正常，大于0 为服务器异常
class ErrorCode {
  ///正常
  static const OK = 0;

  ///参数错误
  static const PARAM_ERR = 1;

  ///内部错误
  static const INTERNAL_ERR = 2;

  ///没有网络
  static const NETWORK_UNREACHABLE = -1000;

  ///请求异常
  static const REQUEST_ERROR = -1001;

  static const NETWORK_ = -10;

  ///请重新登陆，过期或者并顶掉了
  static const TOKEN_FAILED = 244024;

  ///网关授权失败，需要重新登录
  static const GATEWAY_TOKEN_FAILED = 80003;

  ///token过期了，需要刷新token
  static const REFRESH_TOKEN_EXPIRED = 244003;

  /// club已解散
  static const CLUB_DISCARD = 259016;

  /// 用户不存在club
  static const CLUB_MEMBER_DELETED = 259015;

  /// 俱乐部申请已发送
  static const CLUB_ADD_INVITATION_HAS_SEND = 259009;

  /// 俱乐部申请已发送
  static const PAYOUT_CPF_BIND_LIMITERR = 253013;

  ///游客限制使用
  static const GUEST_FORBIDDEN = 244035;

  ///邮箱获取绑定验证码 但是 账号已注册
  static const ACCOUNT_REGISTERED = 244011;

  ///游客转 facebook 绑定 ，已绑定过其他账号
  static const FACEBOOK_BIND = 244027;

  /// 版本太低 出发限制
  static const VERSION_LOW = 244037;

  ///注册转正限制 设备注册数量过多
  static const REGISTER_TOO_MUCH = 244009;
}
