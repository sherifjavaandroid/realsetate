import 'package:flutter/material.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/utils/utils.dart';

class Description extends StatelessWidget {
  const Description({required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    final List<String> descriptionList = <String>[
      'intro_slider1_description'.tr,
      'intro_slider2_description'.tr,
      'intro_slider3_description'.tr
    ];
    return Container(
      height: 70,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: PsDimens.space36),
      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: Text(
        descriptionList[currentIndex].tr,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Utils.isLightMode(context)
                  ? PsColors.text800
                  : PsColors.text400,
            ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
