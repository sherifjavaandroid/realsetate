import 'package:flutter/material.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';

class EmailVerifyBackWidget extends StatelessWidget {
  const EmailVerifyBackWidget({required this.onSignInSelected});
  final Function? onSignInSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: InkWell(
          child: Center(
            child: Text(
              'phone_signin__back_login'.tr,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          onTap: () {
            if (onSignInSelected != null) {
              onSignInSelected!();
            } else {
              Navigator.pop(context);
            }
          }),
    );
  }
}
