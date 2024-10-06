import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({required this.fromSettingSlider});
  final bool fromSettingSlider;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Padding(
      padding: const EdgeInsets.only(
          right: PsDimens.space16,
          top: PsDimens.space32,
          left: PsDimens.space16),
      child: InkWell(
          onTap: () {
            if (!psValueHolder.isAggreTermsAndConditions &&
                !fromSettingSlider) {
              Navigator.pushReplacementNamed(
                  context, RoutePaths.agreeTermsAndCondtion);
            } else if (fromSettingSlider) {
              Navigator.pop(context);
            } else if (psValueHolder.isForceLogin! &&
                Utils.checkUserLoginId(psValueHolder) == 'nologinuser') {
              Navigator.pushReplacementNamed(
                  context, RoutePaths.login_container);
            } else if (psValueHolder.isLanguageConfig! &&
                psValueHolder.showOnboardLanguage) {
              Navigator.pushReplacementNamed(
                  context, RoutePaths.languagesetting);
            } else if (psValueHolder.locationId != null) {
              Navigator.pushReplacementNamed(
                context,
                RoutePaths.home,
              );
            } else {
              Navigator.pushReplacementNamed(
                context,
                RoutePaths.itemLocationList,
              );
            }
          },
          child: Ink(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: PsDimens.space16),
                  width: PsDimens.space84,
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(PsDimens.space20),
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic100
                          : PsColors.achromatic300),
                  child: Padding(
                    padding: const EdgeInsets.only(top: PsDimens.space8),
                    child: Text(
                      'intro_slider_skip'.tr,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: PsColors.text800,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
