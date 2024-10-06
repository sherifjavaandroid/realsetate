import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/chat/user_unread_message_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../common/dialog/chat_noti_dialog.dart';

class ChatIconWithUnreadCount extends StatefulWidget {
  const ChatIconWithUnreadCount(
      {required this.updateSelectedIndexWithAnimation});
  final Function updateSelectedIndexWithAnimation;
  @override
  State<StatefulWidget> createState() =>
      ChatIconWithUnreadCountState<ChatIconWithUnreadCount>();
}

class ChatIconWithUnreadCountState<T extends ChatIconWithUnreadCount>
    extends State<ChatIconWithUnreadCount> {
  int sellerCount = 0;
  int buyerCount = 0;
  late UserUnreadMessageProvider provider;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: PsDimens.space40,
              height: PsDimens.space36,
              margin: const EdgeInsets.only(
                  left: PsDimens.space8, right: PsDimens.space8),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Icon(
                  Remix.chat_3_line,
                  size: 24,
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic500
                      : PsColors.achromatic100,
                ),
              ),
            ),
            Positioned(
                top: 3,
                right: 8,
                child: Consumer<UserUnreadMessageProvider>(builder:
                    (BuildContext context,
                        UserUnreadMessageProvider userUnreadMessageProvider,
                        Widget? child) {
                  if (userUnreadMessageProvider.userUnreadMessage.data !=
                      null) {
                    provider = userUnreadMessageProvider;
                    sellerCount = int.parse(userUnreadMessageProvider
                        .userUnreadMessage.data!.sellerUnreadCount!);
                    buyerCount = int.parse(userUnreadMessageProvider
                        .userUnreadMessage.data!.buyerUnreadCount!);
                    userUnreadMessageProvider.totalUnreadCount =
                        sellerCount + buyerCount;
                    if (Utils.isLoginUserEmpty(psValueHolder) ||
                        userUnreadMessageProvider.totalUnreadCount == 0) {
                      return const SizedBox();
                    } else {
                      if (userUnreadMessageProvider.totalUnreadCount > 0) {
                        Future<dynamic>.delayed(
                            Duration.zero, () => showMessageDialog(context));
                      }
                      return Container(
                        width: PsDimens.space20,
                        height: PsDimens.space16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(PsDimens.space10),
                          color: Theme.of(context)
                              .primaryColor, //PsColors.primary500,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            userUnreadMessageProvider.totalUnreadCount > 9
                                ? '9+'
                                : userUnreadMessageProvider.totalUnreadCount
                                    .toString(),
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: PsColors.achromatic50),
                            maxLines: 1,
                          ),
                        ),
                      );
                    }
                  } else {
                    return const SizedBox();
                  }
                })),
          ],
        ),
        const SizedBox(
          height: PsDimens.space8,
        ),
      ],
    );
  }

  Future<dynamic> showMessageDialog(BuildContext context) async {
    if (!Utils.isShowNotiFromToolbar() && !provider.isShowMessageDialog) {
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return ChatNotiDialog(
                description: 'noti_message__new_message'.tr,
                leftButtonText: 'chat_noti__cancel'.tr,
                rightButtonText: 'chat_noti__open'.tr,
                onAgreeTap: () {
                  widget.updateSelectedIndexWithAnimation(
                      'dashboard__bottom_navigation_message'.tr,
                      PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT);
                });
          });
      provider.isShowMessageDialog = true;
    }
  }
}
