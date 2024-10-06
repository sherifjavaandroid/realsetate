import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class JoinDateWidget extends StatelessWidget {
  const JoinDateWidget();

  @override
  Widget build(BuildContext context) {
    final UserProvider? userProvider = Provider.of<UserProvider>(context);
    return Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('profile__join_on'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(
              width: PsDimens.space6,
            ),
            Text(
              userProvider!.user.data!.addedDateTimeStamp != null &&
                      userProvider.user.data!.addedDateTimeStamp != ''
                  ? Utils.getDateFormat(userProvider.user.data!.addedDate,
                      userProvider.psValueHolder!.dateFormat!)
                  : Utils.changeTimeStampToStandardDateTimeFormat(
                      userProvider.user.data!.addedDateTimeStamp),
              textAlign: TextAlign.start,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.7),
            ),
          ],
        ));
  }
}
