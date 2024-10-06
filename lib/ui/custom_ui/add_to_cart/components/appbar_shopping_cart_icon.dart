import 'package:flutter/material.dart';

import '../../../vendor_ui/add_to_cart/components/appbar_shopping_cart_icon.dart';

class CustomAppbarShoppingCartIcon extends StatefulWidget {
  @override
  State<CustomAppbarShoppingCartIcon> createState() =>
      _CustomAppbarShoppingCartIconState();
}

class _CustomAppbarShoppingCartIconState
    extends State<CustomAppbarShoppingCartIcon> {
  @override
  Widget build(BuildContext context) {
    return const AppbarShoppingCartIcon();
  }
}
