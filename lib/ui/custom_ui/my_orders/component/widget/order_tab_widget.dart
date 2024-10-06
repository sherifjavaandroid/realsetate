import 'package:flutter/material.dart';

import '../../../../vendor_ui/my_orders/component/list/widget/order_tab_widget.dart';

class CustomOrderTabWidget extends StatelessWidget {
  const CustomOrderTabWidget({Key? key,this.text}) : super(key: key);
final String? text;
  @override
  Widget build(BuildContext context) {
    return OrderTabWidget(text:text);
  }
}