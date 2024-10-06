import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/vendor_application/vendor_item_provider.dart';
import '../../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../custom_ui/item/list_item/product_price_widget.dart';
import '../../../../../common/ps_ui_widget.dart';
import '../../../../../common/shimmer_item.dart';
import '../../../../../item/detail/component/info_widgets/vendor_expired_widget.dart';

class OtherUserVendorItemCardWidget extends StatelessWidget {
  const OtherUserVendorItemCardWidget({Key? key, required this.isLoading})
      : super(key: key);
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final VendorItemProvider vendorItemProvider =
        Provider.of<VendorItemProvider>(context);
    final VendorUserDetailProvider vendorUserDetailProvider =
        Provider.of(context);
    void onDetailClick(BuildContext context, int index) {
      if (!isLoading) {
        final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
            productId: vendorItemProvider.vendorItemList.data?[index].id,
            heroTagImage: vendorItemProvider.hashCode.toString(),
            heroTagTitle: vendorItemProvider.hashCode.toString());
        Navigator.pushNamed(context, RoutePaths.productDetail,
            arguments: holder);
      }
    }

    return Stack(children: <Widget>[
      Container(
        margin: const EdgeInsets.symmetric(
            horizontal: PsDimens.space10, vertical: PsDimens.space4),
        child: Column(children: <Widget>[
          if (vendorUserDetailProvider.vendorUserDetail.data?.expiredStatus ==
              PsConst.EXPIRED_NOTI)
            VendorExpiredWidget(vendorExpText: 'vendor_expired_text'.tr)
          else
           const SizedBox(),
          Expanded(
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 280.0, childAspectRatio: 0.65),
                itemCount: vendorItemProvider.vendorItemList.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: PsDimens.space4,
                          vertical: PsDimens.space8),
                      child: isLoading
                          ? const ShimmerItem()
                          : vendorItemProvider.hasData
                              ? GestureDetector(
                                  onTap: () {
                                    onDetailClick(context, index);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Utils.isLightMode(context)
                                          ? PsColors.text50
                                          : PsColors.achromatic700,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(PsDimens.space8)),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Expanded(
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                width: double
                                                    .infinity, //PsDimens.space180,
                                                height: double.infinity,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          PsDimens.space6),
                                                  child: PsNetworkImage(
                                                    photoKey:
                                                        '${vendorItemProvider.vendorItemList.data?[index].hashCode.toString()}${vendorItemProvider.vendorItemList.data?[index].id}${PsConst.HERO_TAG__IMAGE}',
                                                    defaultPhoto:
                                                        vendorItemProvider
                                                            .vendorItemList
                                                            .data?[index]
                                                            .defaultPhoto,
                                                    boxfit: BoxFit.cover,
                                                    imageAspectRation:
                                                        PsConst.Aspect_Ratio_2x,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    if (vendorItemProvider
                                                            .vendorItemList
                                                            .data?[index]
                                                            .isSoldOutItem ??
                                                        false)
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            top:
                                                                PsDimens.space4,
                                                            left:
                                                                PsDimens.space4,
                                                            right: PsDimens
                                                                .space4),
                                                        height:
                                                            PsDimens.space24,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        PsDimens
                                                                            .space4),
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                        child: Padding(
                                                            padding: const EdgeInsets.only(
                                                                top: PsDimens
                                                                    .space4,
                                                                left: PsDimens
                                                                    .space4,
                                                                right: PsDimens
                                                                    .space4),
                                                            child: Text(
                                                                'dashboard__sold_out'
                                                                    .tr,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        color: PsColors.achromatic50))),
                                                      ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: PsDimens.space4,
                                                          left: PsDimens.space4,
                                                          right:
                                                              PsDimens.space4),
                                                      height: PsDimens.space24,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      PsDimens
                                                                          .space4),
                                                          color: PsColors
                                                              .success400),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: PsDimens
                                                                      .space4,
                                                                  left: PsDimens
                                                                      .space4,
                                                                  right: PsDimens
                                                                      .space4),
                                                          child: Text(
                                                              'dashboard__is_featured'
                                                                  .tr,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: PsColors
                                                                          .achromatic50))),
                                                    ),
                                                    if (vendorItemProvider
                                                            .vendorItemList
                                                            .data?[index]
                                                            .isDiscountedItem ??
                                                        false)
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            top:
                                                                PsDimens.space6,
                                                            left:
                                                                PsDimens.space6,
                                                            right: PsDimens
                                                                .space4),
                                                        height: 25,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        PsDimens
                                                                            .space4),
                                                            color: PsColors
                                                                .error500),
                                                        child: Padding(
                                                            padding: const EdgeInsets.only(
                                                                top: PsDimens
                                                                    .space4,
                                                                left: PsDimens
                                                                    .space4,
                                                                right: PsDimens
                                                                    .space4),
                                                            child: Text(
                                                                '${vendorItemProvider.vendorItemList.data?[index].discountRate}% ${'dashboard__is_discount'.tr}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        color: PsColors
                                                                            .achromatic50))),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              if (!Utils.isOwnerItem(psValueHolder, vendorItemProvider.vendorItemList.data?[index] ?? Product()))
                                                Positioned(
                                                    top: PsDimens.space6,
                                                    right: PsDimens.space6,
                                                    child: Container(
                                                        padding: const EdgeInsets.only(
                                                            top:
                                                                PsDimens.space4,
                                                            left:
                                                                PsDimens.space4,
                                                            right:
                                                                PsDimens.space4,
                                                            bottom: PsDimens
                                                                .space4),
                                                        decoration: BoxDecoration(
                                                            color: PsColors
                                                                .achromatic50,
                                                            border: Border.all(
                                                                color: PsColors
                                                                    .achromatic50),
                                                            shape: BoxShape
                                                                .circle),
                                                        child: vendorItemProvider.vendorItemList.data?[index].isFavourited == PsConst.ZERO || Utils.isLoginUserEmpty(psValueHolder)
                                                            ? Icon(
                                                                Icons.favorite_border,
                                                                color: PsColors.text500,
                                                                size: 20)
                                                            : Icon(Icons.favorite, color: Theme.of(context).primaryColor, size: 20))),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: PsDimens.space8,
                                                    right: PsDimens.space8,
                                                    left: PsDimens.space8),
                                                child: Text(
                                                  vendorItemProvider
                                                          .vendorItemList
                                                          .data?[index]
                                                          .title ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: PsDimens.space8,
                                              right: PsDimens.space8,
                                              top: PsDimens.space4,
                                              bottom: PsDimens.space4),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              CustomProductPriceWidget(
                                                product: vendorItemProvider
                                                        .vendorItemList
                                                        .data?[index] ??
                                                    Product(),
                                                tagKey: vendorItemProvider
                                                        .vendorItemList
                                                        .data?[index]
                                                        .hashCode
                                                        .toString() ??
                                                    '',
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: PsDimens.space10),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 12,
                                                      color: Utils.isLightMode(
                                                              context)
                                                          ? PsColors.text500
                                                          : PsColors.text400,
                                                    ),
                                                    Expanded(
                                                        child: Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                left: PsDimens
                                                                    .space4,
                                                                right: PsDimens
                                                                    .space4),
                                                            child: Text(
                                                                psValueHolder
                                                                            .isSubLocation ==
                                                                        PsConst
                                                                            .ONE
                                                                    ? (vendorItemProvider.vendorItemList.data?[index].itemLocationTownship?.townshipName !=
                                                                                '' &&
                                                                            vendorItemProvider.vendorItemList.data?[index].itemLocationTownship?.townshipName !=
                                                                                null)
                                                                        ? // check optional township is empty
                                                                        '${vendorItemProvider.vendorItemList.data?[index].itemLocationTownship?.townshipName}'
                                                                        : '${vendorItemProvider.vendorItemList.data?[index].itemLocation?.name}'
                                                                    : '${vendorItemProvider.vendorItemList.data?[index].itemLocation?.name}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: Utils.isLightMode(
                                                                              context)
                                                                          ? PsColors
                                                                              .text500
                                                                          : PsColors
                                                                              .text400,
                                                                    )))),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox());
                }),
          ),
        ]),
      ),
      PSProgressIndicator(vendorItemProvider.currentStatus)
    ]);
  }
}
