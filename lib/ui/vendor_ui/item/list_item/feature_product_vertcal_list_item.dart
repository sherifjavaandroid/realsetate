import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../custom_ui/item/list_item/product_price_widget.dart';
import '../../../custom_ui/item/list_item/product_shop_owner_info_widget.dart';
// import '../../../../core/vendor/viewobject/product_relation.dart';
import '../../../vendor_ui/common/bluemark_icon.dart';
import '../../common/ps_hero.dart';
import '../../common/ps_ui_widget.dart';
import '../../common/shimmer_item.dart';

class FeaturedProductVerticalListItem extends StatelessWidget {
  const FeaturedProductVerticalListItem(
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
    //print("${PsConfig.ps_app_image_thumbs_url}${subCategory.defaultPhoto.imgPath}");
    animationController.forward();
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    // final bool showDiscount =
    //     valueHolder.isShowDiscount! && product.isDiscountedItem;

    // final Widget _smallDivider = Container(
    //   height: 10,
    //   color: PsColors.text400,
    //   width: 1,
    // );

    // const String itemMileageId = 'ps-itm00026';
    // final int index = product.productRelation!.indexWhere(
    //     (ProductRelation element) => element.coreKeyId == itemMileageId);

    // final bool showItemMileageData = index >= 0 &&
    //     product.productRelation?.elementAt(index).selectedValues?[0].value !=
    //         '';

    // const String itemContidionCustomId = 'ps-itm00004';
    // final int index2 = product.productRelation!.indexWhere(
    //     (ProductRelation element) =>
    //         element.coreKeyId == itemContidionCustomId);

    // final bool showItemConditionData = index2 >= 0 &&
    //     product.productRelation?.elementAt(index2).selectedValues?[0].value !=
    //         '';

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
            opacity: animation,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - animation.value), 0.0),
                child: child));
      },
      child: Container(
        height: (valueHolder.isShowOwnerInfo!) ? 150 : 130,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          border: Border.all(
            color: Utils.isLightMode(context)
                ? PsColors.achromatic100
                : PsColors.achromatic700,
            width: 1.0,
          ),
          color: Utils.isLightMode(context)
              ? PsColors.achromatic100
              : PsColors.achromatic700,
        ),
        margin: const EdgeInsets.only(
            bottom: PsDimens.space16,
            left: PsDimens.space16,
            right: PsDimens.space16),
        padding: const EdgeInsets.only(
            // top: PsDimens.space8,
            left: PsDimens.space12,
            //  bottom: PsDimens.space20,
            right: PsDimens.space12),
        child: isLoading
            ? const ShimmerItem()
            : GestureDetector(
                onTap: () {
                  onDetailClick(context);
                  if (onTap != null) {
                    onTap!();
                  }
                },
                child: Stack(
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: PsDimens.space20, top: PsDimens.space8),
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  child: PsNetworkImage(
                                    width: 105,
                                    height: 105,
                                    photoKey:
                                        '$coreTagKey${product.id}${PsConst.HERO_TAG__IMAGE}',
                                    defaultPhoto: product.defaultPhoto!,
                                    imageAspectRation: PsConst.Aspect_Ratio_2x,
                                    boxfit: BoxFit.cover,
                                    onTap: () {
                                      onDetailClick(context);
                                      if (onTap != null) {
                                        onTap!();
                                      }
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: PsDimens.space6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      if (product.isSoldOutItem)
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          height: 14,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      PsDimens.space4),
                                              color: PsColors.error500),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                // Icon(
                                                //   Remix.delete_back_2_line,
                                                //   size: 12,
                                                //   color: PsColors.white,
                                                // ),
                                                // const SizedBox(
                                                //   width: PsDimens.space2,
                                                // ),
                                                Text('dashboard__sold_out'.tr,
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color: PsColors
                                                                .achromatic50))
                                              ]),
                                        ),
                                      // if (product.paidStatus ==
                                      //     PsConst.PAID_AD_PROGRESS)
                                      //   Container(
                                      //     margin: const EdgeInsets.only(
                                      //         top: PsDimens.space4,
                                      //         left: PsDimens.space4,
                                      //         right: PsDimens.space4),
                                      //     padding: const EdgeInsets.symmetric(
                                      //         horizontal: 2),
                                      //     height: 14,
                                      //     decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(
                                      //             PsDimens.space4),
                                      //         color: PsColors.primary50),
                                      //     child: Row(children: <Widget>[
                                      //       Icon(
                                      //         Remix.fire_fill,
                                      //         size: 12,
                                      //         color: PsColors.primary500,
                                      //       ),
                                      //       const SizedBox(
                                      //         width: PsDimens.space2,
                                      //       ),
                                      //       Text('dashboard__is_featured'.tr,
                                      //           textAlign: TextAlign.start,
                                      //           maxLines: 1,
                                      //           overflow: TextOverflow.ellipsis,
                                      //           style: Theme.of(context)
                                      //               .textTheme
                                      //               .bodyMedium!
                                      //               .copyWith(
                                      //                   fontSize: 10,
                                      //                   color:
                                      //                       PsColors.primary500))
                                      //     ]),
                                      //   ),
                                      if (product.isDiscountedItem)
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          height: 14,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                // Icon(
                                                //   Icons.discount_outlined,
                                                //   size: 12,
                                                //   color: PsColors.white,
                                                // ),
                                                // const SizedBox(
                                                //   width: PsDimens.space2,
                                                // ),
                                                Text(
                                                    '${product.discountRate}% ${'dashboard__is_discount'.tr}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color: PsColors
                                                                .achromatic50))
                                              ]),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: PsDimens.space8,
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                onDetailClick(context);
                                if (onTap != null) {
                                  onTap!();
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 14,
                                    ),
                                    child: Container(
                                      //color: PsColors.mainColor,
                                      width: (!Utils.isOwnerItem(
                                              valueHolder, product))
                                          ? 180
                                          : double.infinity,
                                      child: PsHero(
                                        tag:
                                            '$coreTagKey${product.id}$PsConst.HERO_TAG__TITLE',
                                        child: Text(
                                          product.title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: 16,
                                                  color:
                                                      Utils.isLightMode(context)
                                                          ? PsColors.text800
                                                          : PsColors.text200,
                                                  fontWeight: FontWeight.w600),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomProductPriceWidget(
                                    product: product,
                                    tagKey: coreTagKey!,
                                  ),
                                  // PsHero(
                                  //   tag:
                                  //       '$coreTagKey${product.id}$PsConst.HERO_TAG__UNIT_PRICE',
                                  //   flightShuttleBuilder:
                                  //       Utils.flightShuttleBuilder,
                                  //   child: Material(
                                  //       type: MaterialType.transparency,
                                  //       child: Text(
                                  //         !showDiscount
                                  //             ? product.originalPrice != '0' &&
                                  //                     product.originalPrice !=
                                  //                         ''
                                  //                 ? '${product.itemCurrency!.currencySymbol}${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}'
                                  //                 : 'item_price_free'.tr
                                  //             : '${product.itemCurrency!.currencySymbol}${Utils.getPriceFormat(product.currentPrice!, valueHolder.priceFormat!)}',
                                  //         textAlign: TextAlign.start,
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .bodyMedium!
                                  //             .copyWith(
                                  //                 color: PsColors.primary500,
                                  //                 fontSize: 16,
                                  //                 fontWeight: FontWeight.w700),
                                  //       )),
                                  // ),
                                  // if (showDiscount)
                                  //   const SizedBox(
                                  //     height: PsDimens.space2,
                                  //   ),
                                  // Visibility(
                                  //     maintainSize: true,
                                  //     maintainAnimation: true,
                                  //     maintainState: true,
                                  //     visible: showDiscount,
                                  //     child: Row(
                                  //       children: <Widget>[
                                  //         Text(
                                  //           '${product.itemCurrency!.currencySymbol}${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}  ',
                                  //           textAlign: TextAlign.start,
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .bodyMedium!
                                  //               .copyWith(
                                  //                   color: Utils.isLightMode(
                                  //                           context)
                                  //                       ? PsColors.text400
                                  //                       : PsColors
                                  //                           .text500,
                                  //                   decoration: TextDecoration
                                  //                       .lineThrough,
                                  //                   fontSize: 12),
                                  //         ),
                                  //       ],
                                  //     )),
                                  // const SizedBox(
                                  //   height: PsDimens.space4,
                                  // ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Remix.map_pin_line,
                                        size: 12,
                                        color: PsColors.achromatic500,
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: PsDimens.space4,
                                              right: PsDimens.space4),
                                          child: Text(
                                              product.itemLocation!.name!,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: Utils.isLightMode(
                                                              context)
                                                          ? PsColors.text500
                                                          : PsColors.text400))),
                                      Text(
                                        ',',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: PsColors.text500),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: PsDimens.space4,
                                              right: PsDimens.space4),
                                          child: Text(
                                              valueHolder.isSubLocation ==
                                                      PsConst.ONE
                                                  ? (product.itemLocationTownship!
                                                                  .townshipName !=
                                                              '' &&
                                                          product.itemLocationTownship!
                                                                  .townshipName !=
                                                              null)
                                                      ? // check optional township is empty
                                                      '${product.itemLocationTownship!.townshipName}'
                                                      : ''
                                                  : '${product.itemLocationTownship!.townshipName}',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: Utils.isLightMode(
                                                              context)
                                                          ? PsColors.text500
                                                          : PsColors.text400))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  if (valueHolder.isShowOwnerInfo! &&
                                      product.vendorId != '' &&
                                      valueHolder.vendorFeatureSetting ==
                                          PsConst.ONE)
                                    CustomProductShopOwnerInfoWidget(
                                      tagKey: coreTagKey ?? '',
                                      product: product,
                                    )
                                  else if (valueHolder.isShowOwnerInfo!)
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Stack(children: <Widget>[
                                          PsNetworkCircleImageForUser(
                                            width: PsDimens.space28,
                                            height: PsDimens.space28,
                                            photoKey: '',
                                            imagePath:
                                                product.user?.userCoverPhoto,
                                            boxfit: BoxFit.cover,
                                            onTap: () {
                                              onDetailClick(context);
                                            },
                                          ),
                                          if (product
                                              .user!.isVefifiedBlueMarkUser)
                                            const Positioned(
                                              right: -1,
                                              bottom: -1,
                                              child: BluemarkIcon(),
                                            ),
                                        ]),
                                        const SizedBox(
                                          width: PsDimens.space8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                product.user?.name == ''
                                                    ? 'default__user_name'.tr
                                                    : '${product.user?.name}',
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color:
                                                            Utils.isLightMode(
                                                                    context)
                                                                ? PsColors
                                                                    .text800
                                                                : PsColors
                                                                    .text200)),
                                            Text(
                                                Utils.getDateFormat(
                                                    product.addedDate,
                                                    valueHolder.dateFormat!),
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Utils.isLightMode(
                                                              context)
                                                          ? PsColors.text500
                                                          : PsColors.text400,
                                                    )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  const SizedBox(
                                    height: PsDimens.space8,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                    if (!Utils.isOwnerItem(valueHolder, product))
                      Positioned(
                        right: (Directionality.of(context) == TextDirection.rtl)
                            ? null
                            : 0,
                        left: (Directionality.of(context) == TextDirection.rtl)
                            ? 0
                            : null,
                        top: 8,
                        child: Container(
                          margin: const EdgeInsets.only(left: PsDimens.space4),
                          padding: const EdgeInsets.only(
                              top: PsDimens.space6,
                              left: PsDimens.space6,
                              right: PsDimens.space6,
                              bottom: PsDimens.space6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: PsColors.achromatic50,
                            border: Border.all(color: PsColors.achromatic50),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                onDetailClick(context);
                              },
                              child: product.isFavourited == PsConst.ZERO ||
                                      Utils.isLoginUserEmpty(valueHolder)
                                  ? Icon(Remix.bookmark_line,
                                      color: PsColors.primary500, size: 20)
                                  : Icon(
                                      Remix.bookmark_fill,
                                      size: 20,
                                      color: PsColors.primary500,
                                    )),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  void onDetailClick(BuildContext context) {
    // final ProductDetailAndAddress holder=ProductDetailAndAddress(productDetailIntentHolder: ProductDetailIntentHolder(productId: product.id), shippingAddressHolder: null, billingAddressHolder: null);

    final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
        productId: product.id,
        heroTagImage: coreTagKey! + product.id! + PsConst.HERO_TAG__IMAGE,
        heroTagTitle: coreTagKey! + product.id! + PsConst.HERO_TAG__TITLE);
    Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
  }
}
