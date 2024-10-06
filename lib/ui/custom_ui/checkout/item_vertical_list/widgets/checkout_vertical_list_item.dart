import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../../vendor_ui/checkout/component/item_vertical_list/widgets/checkout_vertical_list_item.dart';

class CustomCheckoutVerticalListItem extends StatelessWidget {
  const CustomCheckoutVerticalListItem(
      {Key? key,
      required this.isSingleItemCheckout,
      required this.isVendorExpired,
      required this.shoppingCartItem,
      required this.vendorId,
      required this.index})
      : super(key: key);
  final ShoppingCartItem shoppingCartItem;
  final String vendorId;
  final bool isSingleItemCheckout;
  final int isVendorExpired;
  final int index;
  @override
  Widget build(BuildContext context) {
    return CheckoutVerticalListItem(
      shoppingCartItem: shoppingCartItem,
      vendorId: vendorId,
      isSingleItemCheckout: isSingleItemCheckout,
      isVendorExpired: isVendorExpired,
      index: index,
    );
  }
}
