import 'package:flutter/material.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';

class FeaturedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /** UI Section is here */
    return Container(
      padding: const EdgeInsets.only(
          bottom: PsDimens.space4,
          top: PsDimens.space2,
          right: PsDimens.space8,
          left: PsDimens.space8),
      child: Text(
        'dashboard__is_featured'.tr,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: PsColors.achromatic50,
            height: 1.7,
            fontWeight: FontWeight.w500),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PsDimens.space8),
          color: PsColors.primary500),
    );
  }
}
