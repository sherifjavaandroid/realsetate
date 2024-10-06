import 'package:flutter/material.dart';

import '../../../vendor_ui/my_orders/view/my_orders_list_view.dart';

class CustomMyOrdersListView extends StatelessWidget {
  const CustomMyOrdersListView({Key? key,this.animationController}) : super(key: key);
  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return  MyOrdersListView(animationController: animationController,);
  }
}