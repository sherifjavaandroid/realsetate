import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/drawer/widgets/notifications_menu_widget.dart';


class CustomNotificationsMenuWidget extends StatelessWidget {
  const CustomNotificationsMenuWidget(
      {this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;

  @override
  Widget build(BuildContext context) {
    return NotificationsMenuWidget(
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }
}
