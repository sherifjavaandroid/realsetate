import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/utils/ps_animation.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/product.dart';
import '../../../custom_ui/item/list_item/feature_product_vertcal_list_item.dart';

class FeaturedProductVerticaltalListWidget extends StatelessWidget {
  const FeaturedProductVerticaltalListWidget(
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
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    print('Near List ::::::::');
    print(productList!.length);
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: isScrollable
                ? const ScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: isLoading
                ? valueHolder.loadingShimmerItemCount
                : productList!.length,
            itemBuilder: (BuildContext context, int index) {
              if (!isLoading &&
                  productList![index].adType == PsConst.GOOGLE_AD_TYPE) {
                return const SizedBox();
              }
              return CustomFeaturedProductVerticalListItem(
                coreTagKey: tagKey,
                product: isLoading ? Product() : productList![index],
                isLoading: isLoading,
                animation: curveAnimation(animationController,
                    index: index, count: productList!.length),
                animationController: animationController,
              );
            }));
  }
}
