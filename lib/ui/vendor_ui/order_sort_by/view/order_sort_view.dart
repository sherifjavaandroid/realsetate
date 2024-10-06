import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../component/widget/sort_type_container.dart';

class OrderSortView extends StatelessWidget {
  const OrderSortView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
        ),
        title: Text(
          'order_sort_by'.tr,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic900
                  : PsColors.achromatic50,
              fontWeight: FontWeight.w500,
              fontSize: PsDimens.space18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SortTypeContainer(
                onTap: () {
                  Navigator.pop(context, '0');
                },
                sortTypeText: 'order_sort_most_recent'.tr),
            SortTypeContainer(
                onTap: () {
                  Navigator.pop(context, '1');
                },
                sortTypeText: 'order_sort_oldest'.tr),
            SortTypeContainer(
                onTap: () {
                  Navigator.pop(context, '2');
                },
                sortTypeText: 'order_price_high_to_low'.tr),
            SortTypeContainer(
                onTap: () {
                  Navigator.pop(context, '3');
                },
                sortTypeText: 'order_price_low_to_high'.tr),
          ],
        ),
      ),
    );
  }
}
