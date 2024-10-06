import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class OtherUserFollowingCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RoutePaths.detailfollowingUserList,
            arguments: userProvider.user.data!.userId,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: PsDimens.space12),
          child: Column(
            children: <Widget>[
              Text(
                userProvider.user.data!.followingCount ?? '',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.text600
                        : PsColors.text100),
                maxLines: 1,
              ),
              Text(
                'profile__following'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.text600
                        : PsColors.text100),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
