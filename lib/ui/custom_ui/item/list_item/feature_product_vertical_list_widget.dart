import 'package:flutter/material.dart';
import '../../../../core/vendor/viewobject/product.dart';
import '../../../vendor_ui/item/list_item/feature_product_vertical_list_widget.dart';

class CustomFeaturedProductVerticaltalListWidget extends StatelessWidget {
  const CustomFeaturedProductVerticaltalListWidget(
      {required this.tagKey,
      required this.productList,
      required this.isLoading,
      required this.animationController,
      this.height,
      this.isScrollable = false});
  final List<Product>? productList;
  final String tagKey;
  final bool isLoading;
  final double? height;
  final AnimationController animationController;
  final bool isScrollable;
  @override
  Widget build(BuildContext context) {
    return FeaturedProductVerticaltalListWidget(
      productList: productList,
      animationController: animationController,
      isLoading: isLoading,
      tagKey: tagKey,
      height: height,
      isScrollable: isScrollable,
    );
  }
}
