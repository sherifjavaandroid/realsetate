import 'package:flutter/material.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';

import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class PsHeaderIconAndDynamicTextWidget extends StatelessWidget {
  const PsHeaderIconAndDynamicTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    final Widget _textWidget = Text(
      text ?? 'app_name'.tr,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color:
              Utils.isLightMode(context) ? PsColors.text800 : PsColors.text50,
          fontSize: 20,
          fontWeight: FontWeight.w600),
    );

    final Widget _imageWidget = Container(
      width: 40,
      height: 40,
      child: Image.asset(
        'assets/images/rec_logo.png',
      ),
    );
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: PsDimens.space32,
          ),
          _imageWidget,
          const SizedBox(
            height: PsDimens.space16,
          ),
          _textWidget,
          const SizedBox(
            height: PsDimens.space16,
          ),
        ],
      ),
    );
  }
}
