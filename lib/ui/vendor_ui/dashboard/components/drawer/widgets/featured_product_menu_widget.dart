import 'package:flutter/material.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class FeaturedProductMenuWidget extends StatelessWidget {
  const FeaturedProductMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return Material(
      //  color: PsColors.achromatic50,
      child: ListTile(
          leading: Icon(Icons.category_outlined,
              size: 22,
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic800
                  : PsColors.achromatic50),
          minLeadingWidth: 0,
          title: Text(
            'dashboard__feature_product'.tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          onTap: () {
            Navigator.pop(context);
            if (updateSelectedIndexWithAnimation != null) {
              updateSelectedIndexWithAnimation!('dashboard__feature_product'.tr,
                  PsConst.REQUEST_CODE__MENU_FEATURED_PRODUCT_FRAGMENT);
            }
          }),
    );
  }
}
