import 'package:flutter/material.dart';
import '../../../vendor_ui/order_successful/view/order_successful_view.dart';

class CustomOrderSuccessfulView extends StatelessWidget {
  const CustomOrderSuccessfulView({
    Key? key,
    required this.orderId,
  }) : super(key: key);
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return OrderSuccessfulView(
      orderId: orderId,
    );
  }
}
