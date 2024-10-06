import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../common/ps_ui_widget.dart';

class OtherUserProfilePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      width: PsDimens.space64,
      height: PsDimens.space64,
      child: PsNetworkCircleImageForUser(
        photoKey: '',
        imagePath: userProvider.user.data!.userCoverPhoto,
        boxfit: BoxFit.cover,
        onTap: () {},
      ),
    );
  }
}
