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
import '../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/item/list_item/product_price_widget.dart';
import '../../../custom_ui/item/list_item/product_shop_owner_info_widget.dart';
import '../../common/bluemark_icon.dart';
import '../../common/ps_ui_widget.dart';
import '../../common/shimmer_item.dart';

class ProductHorizontalListItem extends StatelessWidget {
  const ProductHorizontalListItem({
    Key? key,
    required this.product,
    required this.tagKey,
    this.isLoading = false,
  }) : super(key: key);

  final Product product;
  final String tagKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final AddToCartProvider addToCartProvider =
        Provider.of<AddToCartProvider>(context);

    final bool showDiscount =
        valueHolder.isShowDiscount! && product.isDiscountedItem;

    return Container(
      margin: const EdgeInsets.only(
        right: PsDimens.space12,
      ),
      width: PsDimens.space180,
      child: isLoading
          ? const ShimmerItem()
          : InkWell(
              onTap: () {
                onDetailClick(context, addToCartProvider, valueHolder);
              },
              child: Card(
                elevation: 0.0,
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic100
                    : PsColors.achromatic800,
                child: Container(
                  decoration: BoxDecoration(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic100
                        : PsColors.achromatic700,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(PsDimens.space8)),
                  ),
                  child:
                      // Stack(
                      //   children: <Widget>[
                      Column(
                    //mainAxisSize: MainAxisSize.max,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(PsDimens.space8),
                                child: PsNetworkImage(
                                  width: double.infinity, //PsDimens.space160,
                                  height: 160,
                                  photoKey:
                                      '$tagKey${product.id}${PsConst.HERO_TAG__IMAGE}',
                                  defaultPhoto: product.defaultPhoto,
                                  // boxfit: BoxFit.fill,
                                  imageAspectRation: PsConst.Aspect_Ratio_3x,
                                  onTap: () {
                                    onDetailClick(context, addToCartProvider,
                                        valueHolder);
                                  },
                                  boxfit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    if (product.isSoldOutItem)
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: PsDimens.space4,
                                            left: PsDimens.space8,
                                            right: PsDimens.space4),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                PsDimens.space8),
                                            color: PsColors.error500),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: PsDimens.space4,
                                                left: PsDimens.space4,
                                                bottom: PsDimens.space4,
                                                right: PsDimens.space4),
                                            child: Text(
                                                'dashboard__sold_out'.tr,
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: PsColors
                                                            .achromatic50))),
                                      ),
                                    if (product.paidStatus ==
                                        PsConst.PAID_AD_PROGRESS)
                                      Container(
                                        margin: const EdgeInsets.only(
                                          bottom: PsDimens.space4,
                                          right: PsDimens.space4,
                                          left: PsDimens.space4,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                PsDimens.space8),
                                            color: PsColors.primary500),
                                        child: Padding(
                                            padding: const EdgeInsets.all(
                                                PsDimens.space2),
                                            child: Text(
                                                'dashboard__is_featured'.tr,
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: PsColors
                                                            .achromatic50))),
                                      )
                                  ],
                                ),
                                const Spacer(),
                                if (showDiscount)
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: PsDimens.space4,
                                        left: PsDimens.space8,
                                        right: PsDimens.space4),
                                    // height: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            PsDimens.space8),
                                        color: const Color(0xFF3B82F6)),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: PsDimens.space2,
                                            bottom: PsDimens.space2,
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
                                                    fontSize: 12,
                                                    color: PsColors
                                                        .achromatic50))),
                                  ),
                              ],
                            ),
                            if (!Utils.isOwnerItem(valueHolder, product))
                              Positioned(
                                  top: PsDimens.space6,
                                  right: PsDimens.space6,
                                  child: GestureDetector(
                                      onTap: () {
                                        onDetailClick(context,
                                            addToCartProvider, valueHolder);
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4,
                                              bottom: PsDimens.space4),
                                          decoration: BoxDecoration(
                                              color: PsColors.achromatic50,
                                              border: Border.all(
                                                  color: PsColors.achromatic50),
                                              shape: BoxShape.circle),
                                          child: product.isFavourited ==
                                                      PsConst.ZERO ||
                                                  Utils.isLoginUserEmpty(
                                                      valueHolder)
                                              ? Icon(Icons.bookmark_outline,
                                                  color: PsColors.primary500,
                                                  size: 20)
                                              : Icon(Icons.bookmark,
                                                  color: PsColors.primary500,
                                                  size: 20)))),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: PsDimens.space8,
                                  right: PsDimens.space8,
                                  top: PsDimens.space4),
                              child: Text(
                                product.title!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Utils.isLightMode(context)
                                      ? PsColors.accent500
                                      : PsColors.primary300,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: PsDimens.space6,
                          right: PsDimens.space6,
                        ),
                        child: Row(
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
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontSize: 12,
                                                    color: Utils.isLightMode(
                                                            context)
                                                        ? PsColors.accent500
                                                        : PsColors.primary300,
                                                  )))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: PsDimens.space8,
                          right: PsDimens.space8,
                          top: PsDimens.space2,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomProductPriceWidget(
                              product: product,
                              tagKey: tagKey,
                            ),
                            if (valueHolder.isShowOwnerInfo! &&
                                product.vendorId != '' &&
                                valueHolder.vendorFeatureSetting == PsConst.ONE)
                              CustomProductShopOwnerInfoWidget(
                                tagKey: tagKey,
                                product: product,
                              )
                            else if (valueHolder.isShowOwnerInfo!)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: PsDimens.space4,
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
                                            // width: PsDimens.space40,
                                            // height: PsDimens.space40,
                                            boxfit: BoxFit.cover,
                                            onTap: () {
                                              onDetailClick(
                                                  context,
                                                  addToCartProvider,
                                                  valueHolder);
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
                                            Text(
                                                Utils.getDateFormat(
                                                    product.addedDate,
                                                    valueHolder.dateFormat!),
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 12,
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
                              height: PsDimens.space4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //   ],
                  // ),
                ),
              ),
            ),
    );
  }

  Future<void> onDetailClick(BuildContext context,
      AddToCartProvider addToCartProvider, PsValueHolder valueHolder) async {
    if (!isLoading) {
      final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
          productId: product.id,
          heroTagImage: tagKey + product.id! + PsConst.HERO_TAG__IMAGE,
          heroTagTitle: tagKey + product.id! + PsConst.HERO_TAG__TITLE);

      final dynamic result = await Navigator.pushNamed(
          context, RoutePaths.productDetail,
          arguments: holder);

      if (result) {
        addToCartProvider.loadData(
            requestPathHolder: RequestPathHolder(
                isCheckoutPage: PsConst.ZERO,
                loginUserId: valueHolder.loginUserId,
                languageCode: valueHolder.languageCode));
      }
    }
  }
}
