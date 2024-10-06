import 'package:flutter/material.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class PopularProductMenuWidget extends StatelessWidget {
  const PopularProductMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return Material(
      //color: PsColors.baseColor,
      child: ListTile(
          leading: Icon(Icons.inventory_2_outlined,
              size: 22,
              color: Utils.isLightMode(context)
                  ? PsColors.text800
                  : PsColors.achromatic50),
          minLeadingWidth: 0,
          title: Text(
            'dashboard__popular_product'.tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          onTap: () {
            Navigator.pop(context);
            if (updateSelectedIndexWithAnimation != null) {
              updateSelectedIndexWithAnimation!('dashboard__popular_product'.tr,
                  PsConst.REQUEST_CODE__MENU_TRENDING_PRODUCT_FRAGMENT);
            }
          }),
    );
  }
}
