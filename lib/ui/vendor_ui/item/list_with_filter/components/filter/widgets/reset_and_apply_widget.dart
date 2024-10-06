import 'package:flutter/material.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class ResetAndApplyWidget extends StatelessWidget {
  const ResetAndApplyWidget({
    Key? key,
    required this.handleApply,
    required this.handleReset,
  }) : super(key: key);
  final Function handleReset;
  final Function handleApply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: PsDimens.space16, vertical: 44),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                handleReset();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: PsColors.achromatic100,
                  border: Border.all(
                    color: PsColors.achromatic100,
                  ),
                  borderRadius: BorderRadius.circular(PsDimens.space4),
                ),
                alignment: Alignment.center,
                height: 40,
                width: double.infinity,
                child: Text(
                  'filter_search_reset'.tr,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: PsColors.text800, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                handleApply();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Utils.isLightMode(context)
                      ? PsColors.primary500
                      : PsColors.primary300,
                  borderRadius: BorderRadius.circular(PsDimens.space4),
                ),
                alignment: Alignment.center,
                height: 40,
                width: double.infinity,
                child: Text(
                  'filter_search_Apply'.tr,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: PsColors.text50, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
