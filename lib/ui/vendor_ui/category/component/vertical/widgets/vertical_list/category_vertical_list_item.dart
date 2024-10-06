import 'package:flutter/material.dart';
import '../../../../../../../config/ps_colors.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../common/ps_ui_widget.dart';
import '../../../../../common/shimmer_item.dart';

class CategoryVerticalListItem extends StatelessWidget {
  const CategoryVerticalListItem(
      {Key? key,
      required this.category,
      required this.animationController,
      required this.animation,
      this.isLoading = false})
      : super(key: key);

  final Category category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    animationController!.forward();
    return AnimatedBuilder(
        animation: animationController!,
        child: Container(
          child: isLoading
              ? const ShimmerItem()
              : InkWell(
                  onTap: () {
                    // if (psValueHolder.isShowSubcategory!) {
                    //   goToSubCategoryList(context, category);
                    // } else {
                    goToProductListByCategory(context, category);
                    // }
                  },
                  child: Container(
                    width: 158,
                    height: 169,
                    decoration: BoxDecoration(
                        color: Utils.isLightMode(context)
                            ? PsColors.achromatic50
                            : PsColors.achromatic700,
                        borderRadius: BorderRadius.circular(PsDimens.space12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(PsDimens.space12),
                              topRight: Radius.circular(PsDimens.space12)),
                          child: PsNetworkImage(
                              width: double.infinity,
                              height: 136,
                              photoKey: '',
                              boxfit: BoxFit.cover,
                              defaultPhoto: category.defaultPhoto,
                              imageAspectRation: PsConst.Aspect_Ratio_1x),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Utils.isLightMode(context)
                                      ? PsColors.achromatic100
                                      : PsColors.achromatic700,
                                ),
                                //  color: Colors.black,
                                // border: Border(
                                //   bottom: BorderSide(
                                //     color: Utils.isLightMode(context)
                                //         ? PsColors.borderColor
                                //         : PsColors.text700,
                                //   ),
                                //   left: BorderSide(
                                //     color: Utils.isLightMode(context)
                                //         ? PsColors.borderColor
                                //         : PsColors.text700,
                                //   ),
                                //   right: BorderSide(
                                //     color: Utils.isLightMode(context)
                                //         ? PsColors.borderColor
                                //         : PsColors.text700,
                                //   ),
                                //   top: BorderSide(
                                //     width: 0,
                                //     color: Utils.isLightMode(context)
                                //         ? PsColors.borderColor
                                //         : PsColors.text700,
                                //   ),
                                // ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(PsDimens.space12),
                                  bottomRight:
                                      Radius.circular(PsDimens.space12),
                                )),
                            child: Center(
                              child: Text(
                                category.catName!,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Utils.isLightMode(context)
                                            ? PsColors.text800
                                            : PsColors.text200,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //           child: Ink(
                  //             child: Center(
                  //               child: Column(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: <Widget>[

                  //                   // cat image
                  //                   ClipRRect(
                  //                     borderRadius:
                  //                         BorderRadius.circular(PsDimens.space24),
                  //                     child: Container(
                  //                       width: PsDimens.space44,
                  //                       height: PsDimens.space44,
                  //                       color: Utils.isLightMode(context)
                  //                           ? PsColors.text100
                  //                           : Colors.white54,
                  //                       padding: const EdgeInsets.all(PsDimens.space10),
                  //                       child: PsNetworkIcon(
                  //                         imageAspectRation: PsConst.Aspect_Ratio_1x,
                  //                         photoKey: '',
                  //                         defaultIcon: category.defaultIcon,
                  //                         boxfit: BoxFit.cover,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   const SizedBox(
                  //                     height: PsDimens.space8,
                  //                   ),
                  //                   // cat name
                  //                   Flexible(
                  //                     child: Text(
                  //                       category.catName!,
                  //                       textAlign: TextAlign.center,
                  //                       overflow: TextOverflow.ellipsis,
                  //                       maxLines: 1,
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .bodyLarge!
                  //                           .copyWith(
                  //                               color: Utils.isLightMode(context)
                  //                                   ? PsColors.secondary600
                  //                                   : PsColors.textColor2,
                  //                               fontSize: 16),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //          )
                ),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - animation!.value), 0.0),
                child: child),
          );
        });
  }

  void goToSubCategoryList(BuildContext context, Category category) {
    Navigator.pushNamed(context, RoutePaths.subCategoryGrid,
        arguments: category);
  }

  void goToProductListByCategory(BuildContext context, Category category) {
    final ProductParameterHolder productParameterHolder =
        ProductParameterHolder().getLatestParameterHolder();
    productParameterHolder.catId = category.catId;
    Navigator.pushNamed(context, RoutePaths.filterProductList,
        arguments: ProductListIntentHolder(
          appBarTitle: category.catName,
          productParameterHolder: productParameterHolder,
        ));
  }
}
