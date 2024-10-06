import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';

class DiscountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<ItemDetailProvider>(context).product;
    /** UI Section is here */
    return Container(
      margin: const EdgeInsets.only(top: PsDimens.space6),
      padding: const EdgeInsets.only(
          bottom: PsDimens.space4,
          top: PsDimens.space2,
          right: PsDimens.space8,
          left: PsDimens.space8),
      child: Text(
        '${product.discountRate}% ' + 'dashboard__is_discount'.tr,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: PsColors.achromatic50,
            height: 1.7,
            fontWeight: FontWeight.w500),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PsDimens.space8),
          color: const Color(0xFF3B82F6)),
    );
  }
}
