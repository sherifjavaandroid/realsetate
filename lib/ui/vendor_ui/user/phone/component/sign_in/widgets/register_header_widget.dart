import 'package:flutter/material.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';

class PhoneSignHeaderIconAndTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget _textWidget = Text(
      'login__phone_signin'.tr,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: PsColors.achromatic900 // color: PsColors.primary500,
              ),
    );

    final Widget _imageWidget = Container(
      width: 40,
      height: 40,
      child: Image.asset(
        'assets/images/rec_logo.png',
      ),
    );
    return Column(
      children: <Widget>[
        const SizedBox(
          height: PsDimens.space32,
        ),
        _imageWidget,
        const SizedBox(
          height: PsDimens.space8,
        ),
        _textWidget,
        const SizedBox(
          height: PsDimens.space52,
        ),
      ],
    );
  }
}
