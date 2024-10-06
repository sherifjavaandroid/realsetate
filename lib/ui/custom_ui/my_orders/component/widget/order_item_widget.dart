import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/item_info.dart';
import '../../../../vendor_ui/my_orders/component/list/widget/order_item_widget.dart';

class CustomOrderItemWidget extends StatelessWidget {
  const CustomOrderItemWidget(
      {Key? key,
      this.itemCount,
      this.orderCode,
      this.orderStatus,
      this.paymentDate,
      this.total,
      this.orderStatusColor,
      this.itemInfo})
      : super(key: key);
  final String? orderCode;
  final String? orderStatus;
  final String? paymentDate;
  final int? itemCount;
  final String? total;
  final String? orderStatusColor;
  final List<ItemInfo>? itemInfo;
  @override
  Widget build(BuildContext context) {
    return OrderItemWidget(
        orderCode: orderCode,
        orderStatus: orderStatus,
        paymentDate: paymentDate,
        itemCount: itemCount,
        total: total,
        orderStatusColor: orderStatusColor,
        itemInfo: itemInfo);
  }
}
