import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../vendor_ui/item/list_item/feature_product_vertcal_list_item.dart';

class CustomFeaturedProductVerticalListItem extends StatelessWidget {
  const CustomFeaturedProductVerticalListItem(
      {Key? key,
      required this.product,
      this.onTap,
      this.coreTagKey,
      required this.animationController,
      required this.animation,
      this.isLoading = false})
      : super(key: key);

  final Product product;
  final Function? onTap;
  final AnimationController animationController;
  final Animation<double> animation;
  final String? coreTagKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FeaturedProductVerticalListItem(
        product: product,
        animationController: animationController,
        animation: animation,
        coreTagKey: coreTagKey,
        onTap: onTap,
        isLoading: isLoading);
  }
}
