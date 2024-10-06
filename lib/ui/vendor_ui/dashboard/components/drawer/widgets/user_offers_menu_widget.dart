import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class UserOfferMenuWidget extends StatelessWidget {
  const UserOfferMenuWidget({
    this.updateSelectedIndexWithAnimation,
  });
  final Function? updateSelectedIndexWithAnimation;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return Material(
      // color: PsColors.baseColor,
      child: ListTile(
          leading: Icon(Icons.account_balance_wallet_outlined,
              size: 22,
              color: Utils.isLightMode(context)
                  ? PsColors.text800
                  : PsColors.achromatic50),
          minLeadingWidth: 0,
          title: Text(
            valueHolder.selectChatType == PsConst.CHAT_AND_APPOINTMENT
                ? 'chat_view__make_book_button_name'.tr
                : 'home__menu_drawer_user_offers'.tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          onTap: () {
            Navigator.pop(context);
            if (updateSelectedIndexWithAnimation != null) {
              updateSelectedIndexWithAnimation!(
                  valueHolder.selectChatType == PsConst.CHAT_AND_APPOINTMENT
                      ? 'chat_view__make_book_button_name'.tr
                      : 'home__menu_drawer_user_offers'.tr,
                  PsConst.REQUEST_CODE__MENU_OFFER_FRAGMENT);
            }
          }),
    );
  }
}
