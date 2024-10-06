import 'package:flutter/material.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';

import '../../../../vendor_ui/dashboard/components/app_bar/appbar.dart';

class CustomDashboardAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomDashboardAppBar(
      {required this.appBarTitle,
      required this.appBarTitleName,
      required this.currentIndex,
      required this.updateCurrentIndex,
      required this.userProvider});
  final String appBarTitle;
  final String appBarTitleName;
  final int? currentIndex;
  final Function updateCurrentIndex;
  final UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return DashboardAppBar(
      appBarTitle: appBarTitle,
      appBarTitleName: appBarTitleName,
      currentIndex: currentIndex,
      updateCurrentIndex: updateCurrentIndex,
      userProvider: userProvider,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
