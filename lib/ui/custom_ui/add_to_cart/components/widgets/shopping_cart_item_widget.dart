import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../../vendor_ui/add_to_cart/components/widgets/shopping_cart_item_widget.dart';

class CustomShoppingCartItemWidget extends StatelessWidget {
  const CustomShoppingCartItemWidget(
      {Key? key,
      required this.shoppingCartItem,
      required this.vendorId,
      required this.isVedorExpired,
      required this.index,
      required this.isAvailableCart})
      : super(key: key);
  final ShoppingCartItem shoppingCartItem;
  final String vendorId;
  final int isVedorExpired;
  final int index;
  final bool isAvailableCart;

  @override
  Widget build(BuildContext context) {
    return ShoppingCartItemWidget(
      shoppingCartItem: shoppingCartItem,
      vendorId: vendorId,
      isVedorExpired: isVedorExpired,
      index: index,
      isAvailableCart: isAvailableCart,
    );
  }
}
