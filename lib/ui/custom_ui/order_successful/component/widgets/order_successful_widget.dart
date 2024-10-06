import 'package:flutter/material.dart';
import '../../../../vendor_ui/order_successful/component/widgets/order_successful_widget.dart';

class CustomOrderSuccessfulWidget extends StatelessWidget {
  const CustomOrderSuccessfulWidget({
    Key? key,
    required this.orderId,
  }) : super(key: key);
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return OrderSuccessfulWidget(
      orderId: orderId,
    );
  }
}
