import 'package:flutter/material.dart';
import '../../../../../vendor_ui/checkout/component/payment/widgets/payment_role_widget.dart';

class CustomPaymentRoleWidget extends StatelessWidget {
  const CustomPaymentRoleWidget({
    Key? key,
    required this.image,
    required this.paymentName,
    this.groupValue,
    required this.isSelected,
    this.onChanged,
    required this.value,
  }) : super(key: key);
  final Image image;
  final String paymentName;
  final int value;
  final int? groupValue;
  final bool isSelected;
  final void Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return PaymentRoleWidget(
      image: image,
      paymentName: paymentName,
      value: value,
      groupValue: groupValue,
      isSelected: isSelected,
      onChanged: onChanged,
    );
  }
}
