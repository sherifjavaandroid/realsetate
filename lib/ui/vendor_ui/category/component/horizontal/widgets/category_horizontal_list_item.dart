import 'package:flutter/material.dart';
import '../../../../../../config/ps_colors.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_list_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../common/ps_ui_widget.dart';
import '../../../../common/shimmer_item.dart';

class CategoryHorizontalListItem extends StatelessWidget {
  const CategoryHorizontalListItem({
    Key? key,
    required this.category,
    this.isLoading = false,
  }) : super(key: key);

  final Category category;
  final bool isLoading;

  void goToSubCategoryList(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.subCategoryGrid,
        arguments: category);
  }

  void goToProductListByCategory(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    final ProductParameterHolder productParameterHolder =
        ProductParameterHolder().getLatestParameterHolder();
    productParameterHolder.catId = category.catId;
    Navigator.pushNamed(context, RoutePaths.filterProductList,
        arguments: ProductListIntentHolder(
          appBarTitle: category.catName,
          productParameterHolder: productParameterHolder,
        ));
  }

  @override
  Widget build(BuildContext context) {
    //  final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: PsDimens.space6, vertical: PsDimens.space20),
      decoration: BoxDecoration(
        color: Utils.isLightMode(context)
            ? PsColors.achromatic100
            : PsColors.achromatic700,
        borderRadius: const BorderRadius.all(Radius.circular(PsDimens.space50)),
      ),
      height: PsDimens.space20,
      child: isLoading
          ? const ShimmerItem()
          : InkWell(
              onTap: () {
                // if (psValueHolder.isShowSubcategory!) {
                //   goToSubCategoryList(context);
                // } else {
                goToProductListByCategory(context);
                // }
              },
              // child: Ink(
              //  child:
              //  Center(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //cat image
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(PsDimens.space24),
                        child: Container(
                          width: PsDimens.space40,
                          height: PsDimens.space40,
                          color: Utils.isLightMode(context)
                              ? PsColors.achromatic100
                              : PsColors.achromatic200,
                          // padding: const EdgeInsets.all(PsDimens.space10),
                          child: PsNetworkImage(
                            imageAspectRation: PsConst.Aspect_Ratio_1x,
                            photoKey: '',
                            defaultPhoto: category.defaultPhoto,
                            boxfit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: PsDimens.space4,
                    ),
                    //cat name
                    Text(
                      category.catName!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.accent500
                              : PsColors.primary300,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(
                      width: PsDimens.space20,
                    )
                  ],
                ),
              ),
              // ),
              //),
            ),
    );
  }
}
