import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/dashboard/components/drawer/widgets/shopping_cart_menu_widget.dart';

class CustomShoppingCartMenuWidget extends StatelessWidget {
  const CustomShoppingCartMenuWidget({this.updateSelectedIndexWithAnimation,});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return ShoppingCartMenuWidget(
      updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
    );
  }
}