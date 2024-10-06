import 'package:flutter/material.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class NotificationsMenuWidget extends StatelessWidget {
  const NotificationsMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
          leading: Icon(Icons.notifications_none,
              size: 22,
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic800
                  : PsColors.achromatic50),
          minLeadingWidth: 0,
          title: Text(
            'home__drawer_menu_notifications_item'.tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          onTap: () {
            Navigator.pop(context);
            if (updateSelectedIndexWithAnimation != null) {
              updateSelectedIndexWithAnimation!(
                  'home__drawer_menu_notifications_item'.tr,
                  PsConst.REQUEST_CODE__MENU_NOTIFICATIONS_FRAGMENT);
            }
          }),
    );
  }
}
