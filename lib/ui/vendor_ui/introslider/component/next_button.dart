import 'package:flutter/material.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';

class NextButton extends StatelessWidget {
  const NextButton({required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      minWidth: PsDimens.space140,
      color: PsColors.primary500,
      child: Text(
        'intro_slider_next'.tr,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: PsColors.achromatic50, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: onTap as void Function(),
    );
  }
}
