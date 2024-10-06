import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class ShoppingCartMenuWidget extends StatelessWidget {
  const ShoppingCartMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return Material(
      //color: PsColors.achromatic50,
      child: ListTile(
          leading: Icon(Icons.shopping_bag_outlined,
              size: 22,
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic800
                  : PsColors.achromatic50),
          minLeadingWidth: 0,
          title: Text(
            'shopping_cart'.tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          onTap: () {
            Utils.navigateOnUserVerificationView(context, () {
              Navigator.pop(context);
              if (updateSelectedIndexWithAnimation != null) {
                updateSelectedIndexWithAnimation!('shopping_cart'.tr,
                    PsConst.REQUEST_CODE__MENU_SHOPPING_CART_FRAGMENT);
              }
            });
          }),
    );
  }
}
