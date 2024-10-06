import 'package:flutter/material.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';

class SortTypeContainer extends StatelessWidget {
  const SortTypeContainer({Key? key, required this.sortTypeText, this.onTap})
      : super(key: key);
  final String sortTypeText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Utils.isLightMode(context)
            ? PsColors.achromatic100
            : PsColors.achromatic700,
        margin: const EdgeInsets.all(PsDimens.space12),
        padding: const EdgeInsets.all(PsDimens.space14),
        child: Text(
          sortTypeText,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
