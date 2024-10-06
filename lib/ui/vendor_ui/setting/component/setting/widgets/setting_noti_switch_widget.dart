import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/common/notification_provider.dart';
import '../../../../../../core/vendor/provider/common/subscribe_topic_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/holder/noti_register_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/noti_unregister_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/subscripe_topic_parameter_holder.dart';

class SettingNotiSwitchWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingNotiSwitchWidgetState();
}

class _SettingNotiSwitchWidgetState extends State<SettingNotiSwitchWidget> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  bool? isSwitched = true;
  SubscribeTopicProvider? subscribeTopicProvider;

  @override
  Widget build(BuildContext context) {
    late NotificationProvider notiProvider =
        Provider.of<NotificationProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    if (notiProvider.psValueHolder!.notiSetting != null) {
      isSwitched = notiProvider.psValueHolder!.notiSetting;
    }
    notiProvider = Provider.of<NotificationProvider>(context);
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<SubscribeTopicProvider?>(
            create: (BuildContext context) {
          subscribeTopicProvider = SubscribeTopicProvider(context: context);
          return subscribeTopicProvider;
        })
      ],
      child: Consumer<SubscribeTopicProvider>(
        builder: (BuildContext context,
                SubscribeTopicProvider subscribeTopicProvider, Widget? child) =>
            Container(
                margin: const EdgeInsets.only(top: PsDimens.space4),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: PsDimens.space16,
                      right: PsDimens.space16,
                      top: PsDimens.space12),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'noti_setting__onof'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Utils.isLightMode(context)
                                      ? PsColors.text800
                                      : PsColors.text50,
                                ),
                          ),
                          SizedBox(
                            width: 52,
                            height: 24,
                            child: Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                  value: isSwitched!,
                                  onChanged: (bool value) async {
                                    setState(() {
                                      isSwitched = value;
                                      notiProvider.psValueHolder!.notiSetting =
                                          value;
                                    });
                                    await notiProvider
                                        .replaceNotiSetting(value);
                                    if (isSwitched == true) {
                                      subscribeTopicProvider =
                                          SubscribeTopicProvider(
                                              context: context);
                                      await subscribeTopicProvider.postData(
                                          requestBodyHolder:
                                              SubscripeTopicParameterHolder(
                                                  token: notiProvider
                                                      .psValueHolder!
                                                      .deviceToken,
                                                  topic: 'broadcast'),
                                          requestPathHolder: RequestPathHolder(
                                              languageCode: notiProvider
                                                      .psValueHolder
                                                      ?.languageCode ??
                                                  'en'));
                                      // _fcm.subscribeToTopic('broadcast');
                                      if (notiProvider
                                                  .psValueHolder!.deviceToken !=
                                              null &&
                                          notiProvider
                                                  .psValueHolder!.deviceToken !=
                                              '') {
                                        final String? loginUserId =
                                            Utils.checkUserLoginId(
                                                notiProvider.psValueHolder!);

                                        final NotiRegisterParameterHolder
                                            notiRegisterParameterHolder =
                                            NotiRegisterParameterHolder(
                                                platformName: PsConst.PLATFORM,
                                                deviceId: notiProvider
                                                    .psValueHolder!.deviceToken,
                                                loginUserId: loginUserId);
                                        notiProvider.rawRegisterNotiToken(
                                            notiRegisterParameterHolder.toMap(),
                                            loginUserId!,
                                            langProvider!
                                                .currentLocale.languageCode);
                                      }
                                    } else {
                                      _fcm.unsubscribeFromTopic('broadcast');
                                      if (notiProvider
                                                  .psValueHolder!.deviceToken !=
                                              null &&
                                          notiProvider
                                                  .psValueHolder!.deviceToken !=
                                              '') {
                                        final String? loginUserId =
                                            Utils.checkUserLoginId(
                                                notiProvider.psValueHolder!);
                                        final NotiUnRegisterParameterHolder
                                            notiUnRegisterParameterHolder =
                                            NotiUnRegisterParameterHolder(
                                                platformName: PsConst.PLATFORM,
                                                deviceId: notiProvider
                                                    .psValueHolder!.deviceToken,
                                                userId: loginUserId);
                                        notiProvider.rawUnRegisterNotiToken(
                                            notiUnRegisterParameterHolder
                                                .toMap(),
                                            loginUserId!,
                                            langProvider!
                                                .currentLocale.languageCode);
                                      }
                                    }
                                  },
                                  // trackColor: Theme.of(context).primaryColor,
                                  activeColor: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Divider(
                          height: PsDimens.space2,
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
