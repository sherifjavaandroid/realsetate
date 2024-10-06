import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class MyOrdersMenuWidget extends StatelessWidget {
  const MyOrdersMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
          leading: SvgPicture.asset(
            'assets/images/package_2.svg',
            width: 23,
            height: 23,
            colorFilter: ColorFilter.mode(
                Utils.isLightMode(context)
                    ? PsColors.achromatic800
                    : PsColors.achromatic50,
                BlendMode.srcIn),
          ),
          minLeadingWidth: 0,
          title: Text(
            'home__menu_drawer_my_orders'.tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          onTap: () {
            Navigator.pop(context);
            if (updateSelectedIndexWithAnimation != null) {
              updateSelectedIndexWithAnimation!(
                  'home__menu_drawer_my_orders'.tr,
                  PsConst.REQUEST_CODE__MENU_ORDERS_FRAGMENT);
            }
          }),
    );
  }
}
