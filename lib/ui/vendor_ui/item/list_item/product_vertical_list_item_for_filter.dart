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
import '../../common/bluemark_icon.dart';
import '../../common/ps_ui_widget.dart';
import '../../common/shimmer_item.dart';

class ProductVerticalListItemForFilter extends StatelessWidget {
  const ProductVerticalListItemForFilter(
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
    // ignore: unused_local_variable
    final bool showDiscount =
        valueHolder.isShowDiscount! && product.isDiscountedItem;
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
        margin: const EdgeInsets.symmetric(
            horizontal: PsDimens.space4, vertical: PsDimens.space8),
        child: isLoading
            ? const ShimmerItem()
            : GestureDetector(
                onTap: () {
                  onDetailClick(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic100
                        : PsColors.achromatic700,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(PsDimens.space8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          //image
                          Container(
                            width: double.infinity,
                            height: 110,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(PsDimens.space4),
                              child: PsNetworkImage(
                                photoKey:
                                    '$coreTagKey${product.id}${PsConst.HERO_TAG__IMAGE}',
                                defaultPhoto: product.defaultPhoto,
                                boxfit: BoxFit.cover,
                                imageAspectRation: PsConst.Aspect_Ratio_3x,
                                onTap: () {
                                  onDetailClick(context);
                                },
                              ),
                            ),
                          ),

                          // is sold out
                          Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (product.isSoldOutItem)
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: PsDimens.space4,
                                        left: PsDimens.space4,
                                        right: PsDimens.space4),
                                    height: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            PsDimens.space4),
                                        color: PsColors.error500),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: PsDimens.space4,
                                            left: PsDimens.space4,
                                            right: PsDimens.space4),
                                        child: Text('dashboard__sold_out'.tr,
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: PsColors
                                                        .achromatic50))),
                                  ),
                                if (product.paidStatus ==
                                    PsConst.PAID_AD_PROGRESS)
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: PsDimens.space4,
                                        left: PsDimens.space4,
                                        right: PsDimens.space4),
                                    height: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            PsDimens.space4),
                                        color: PsColors.primary500),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: PsDimens.space4,
                                            left: PsDimens.space4,
                                            right: PsDimens.space4),
                                        child: Text('dashboard__is_featured'.tr,
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: PsColors
                                                        .achromatic50))),
                                  ),
                                //*********discount */
                                if (showDiscount)
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: PsDimens.space4,
                                        left: PsDimens.space4,
                                        right: PsDimens.space4),
                                    height: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            PsDimens.space4),
                                        color: const Color(0xFF3B82F6)),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: PsDimens.space4,
                                            left: PsDimens.space4,
                                            right: PsDimens.space4),
                                        child: Text(
                                            '${product.discountRate}% ${'dashboard__is_discount'.tr}',
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: PsColors
                                                        .achromatic50))),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: PsDimens.space4,
                                        left: PsDimens.space8,
                                        right: PsDimens.space8),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          95,
                                      child: Text(
                                        product.title!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Utils.isLightMode(context)
                                              ? PsColors.accent500
                                              : PsColors.primary300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!Utils.isOwnerItem(valueHolder, product))
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: PsDimens.space4,
                                      left: PsDimens.space8,
                                      right: PsDimens.space8),
                                  child: GestureDetector(
                                      onTap: () {
                                        onDetailClick(context);
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(
                                              PsDimens.space4),
                                          decoration: BoxDecoration(
                                              color: PsColors.achromatic50,
                                              border: Border.all(
                                                  color: PsColors.achromatic50),
                                              shape: BoxShape.circle),
                                          child: product.isFavourited ==
                                                      PsConst.ZERO ||
                                                  Utils.isLoginUserEmpty(
                                                      valueHolder)
                                              ? Icon(Remix.bookmark_line,
                                                  color: PsColors.primary500,
                                                  size: 20)
                                              : Icon(Remix.bookmark_fill,
                                                  color: PsColors.primary500,
                                                  size: 20)))),
                          ]),
                      Container(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space8,
                            right: PsDimens.space8,
                            top: PsDimens.space4,
                            bottom: PsDimens.space4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomProductPriceWidget(
                              product: product,
                              tagKey: coreTagKey!,
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: <Widget>[
                            //         //**price */
                            //         PsHero(
                            //           tag:
                            //               '$coreTagKey${product.id}$PsConst.HERO_TAG__UNIT_PRICE',
                            //           flightShuttleBuilder:
                            //               Utils.flightShuttleBuilder,
                            //           child: Material(
                            //               type: MaterialType.transparency,
                            //               child: Text(
                            //                 !showDiscount
                            //                     ? product.originalPrice !=
                            //                                 '0' &&
                            //                             product.originalPrice !=
                            //                                 ''
                            //                         ? '${product.itemCurrency!.currencySymbol}${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}'
                            //                         : 'item_price_free'.tr
                            //                     : '${product.itemCurrency!.currencySymbol}${Utils.getPriceFormat(product.currentPrice!, valueHolder.priceFormat!)}',
                            //                 textAlign: TextAlign.start,
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodyMedium!
                            //                     .copyWith(
                            //                         color: PsColors.primary500,
                            //                         fontSize: 14),
                            //               )),
                            //         ),
                            //           //**discount price */
                            //         Visibility(
                            //             maintainSize: true,
                            //             maintainAnimation: true,
                            //             maintainState: true,
                            //             visible: showDiscount,
                            //             child: Row(
                            //               children: <Widget>[
                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       bottom: PsDimens.space4),
                            //                   child: Text(
                            //                     '${product.itemCurrency!.currencySymbol}${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}',
                            //                     textAlign: TextAlign.start,
                            //                     style: Theme.of(context)
                            //                         .textTheme
                            //                         .bodyMedium!
                            //                         .copyWith(
                            //                             color: Utils
                            //                                     .isLightMode(
                            //                                         context)
                            //                                 ? PsColors
                            //                                     .text400
                            //                                 : PsColors
                            //                                     .text500,
                            //                             decoration:
                            //                                 TextDecoration
                            //                                     .lineThrough,
                            //                             fontSize: 12),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ))
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            //Location*****
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      const Icon(
                                        Remix.map_pin_line,
                                        size: 12,
                                      ),
                                      Expanded(
                                          child: Padding(
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
                                                          : '${product.itemLocation!.name}'
                                                      : '${product.itemLocation!.name}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontSize: 12,
                                                        color:
                                                            Utils.isLightMode(
                                                                    context)
                                                                ? PsColors
                                                                    .accent500
                                                                : PsColors
                                                                    .primary300,
                                                      )))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Profile
                            if (valueHolder.isShowOwnerInfo! &&
                                product.vendorId != '' &&
                                valueHolder.vendorFeatureSetting == PsConst.ONE)
                              CustomProductShopOwnerInfoWidget(
                                tagKey: coreTagKey ?? '',
                                product: product,
                              )
                            else if (valueHolder.isShowOwnerInfo!)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: PsDimens.space4,
                                  top: PsDimens.space4,
                                  right: PsDimens.space4,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Stack(children: <Widget>[
                                      Container(
                                        child: SizedBox(
                                          width: PsDimens.space40,
                                          height: PsDimens.space40,
                                          child: PsNetworkCircleImageForUser(
                                            photoKey: '',
                                            imagePath:
                                                product.user?.userCoverPhoto,
                                            boxfit: BoxFit.cover,
                                            onTap: () {
                                              onDetailClick(context);
                                            },
                                          ),
                                        ),
                                      ),
                                      if (product.user!.isVefifiedBlueMarkUser)
                                        const Positioned(
                                          right: -1,
                                          bottom: -1,
                                          child: BluemarkIcon(),
                                        ),
                                    ]),
                                    const SizedBox(width: PsDimens.space8),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: PsDimens.space8,
                                            top: PsDimens.space8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                      product.user?.name == ''
                                                          ? 'default__user_name'
                                                              .tr
                                                          : '${product.user?.name}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                                color: Utils.isLightMode(
                                                                        context)
                                                                    ? PsColors
                                                                        .text800
                                                                    : PsColors
                                                                        .text100,
                                                              )),
                                                ),
                                              ],
                                            ),
                                            Text('${product.addedDateStr}',
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Utils.isLightMode(
                                                              context)
                                                          ? PsColors.text500
                                                          : PsColors.text400,
                                                    ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: PsDimens.space8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> onDetailClick(BuildContext context) async {
    if (!isLoading) {
      print(product.defaultPhoto!.imgPath);
      final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
          productId: product.id,
          heroTagImage: coreTagKey! + product.id! + PsConst.HERO_TAG__IMAGE,
          heroTagTitle: coreTagKey! + product.id! + PsConst.HERO_TAG__TITLE);
      Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
    }

    if (onTap != null) {
      onTap!();
    }
  }
}
