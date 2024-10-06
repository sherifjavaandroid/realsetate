import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/drawer/widgets/my_orders_menu_widget.dart';

class CustomMyOrdersMenuWidget extends StatelessWidget {
  const CustomMyOrdersMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;

  @override
  Widget build(BuildContext context) {
    return MyOrdersMenuWidget(
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }
}