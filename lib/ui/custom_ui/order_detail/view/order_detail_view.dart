import 'package:flutter/material.dart';
import '../../../vendor_ui/order_detail/view/order_detail_view.dart';

class CustomOrderDetailView extends StatelessWidget {
  const CustomOrderDetailView({
    Key? key,
    required this.orderId,
  }) : super(key: key);
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return OrderDetailView(
      orderId: orderId,
    );
  }
}
