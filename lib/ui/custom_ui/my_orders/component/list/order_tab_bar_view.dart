import 'package:flutter/material.dart';

import '../../../../vendor_ui/my_orders/component/list/order_tab_bar_view.dart';

class CustomOrdersTabBarView extends StatelessWidget {
  const CustomOrdersTabBarView({Key? key,required this.widget}) : super(key: key);
 final Widget widget;
  @override
  Widget build(BuildContext context) {
    return OrdersTabBarView(widget:widget);
  }
}