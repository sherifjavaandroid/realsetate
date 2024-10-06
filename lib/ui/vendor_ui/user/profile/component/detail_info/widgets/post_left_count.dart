import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class PostLeftInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: PsDimens.space12),
        child: Column(
          children: <Widget>[
            Text(
              userProvider.user.data!.remainingPost!,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.text600
                        : PsColors.text50,
                  ),
              maxLines: 1,
            ),
            Container(
              // width: 50,
              child: Text(
                'Available'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.text600
                        : PsColors.text50,
                    fontSize: 16),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
