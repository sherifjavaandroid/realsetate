import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/map_pin_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../core/vendor/viewobject/product_relation.dart';
import '../../../../../vendor_ui/common/price_dollar.dart';

class LocationWithPriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final Product product = itemDetailProvider.product;
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);

    List<ProductRelation> qtyObj = <ProductRelation>[];

    final List<ProductRelation> filteredList =
        product.productRelation?.where((ProductRelation pr) {
              return pr.coreKeyId == 'ps-itm00046';
            }).toList() ??
            <ProductRelation>[];

    if (filteredList.isNotEmpty) {
      qtyObj = filteredList;
      if (qtyObj != <dynamic>[]) {
        itemDetailProvider.quantity = int.parse(qtyObj[0].value.toString());
      }
    }
    /** UI Section is here */
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(
            top: PsDimens.space8,
            left: PsDimens.space16,
            right: Directionality.of(context) == TextDirection.rtl
                ? PsDimens.space6
                : PsDimens.space14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    LocationWidget(),
                    const SizedBox(height: PsDimens.space8),
                    Text(
                      Utils.getDateFormat(
                          product.addedDate, psValueHolder.dateFormat!),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Utils.isLightMode(context)
                                ? PsColors.text500
                                : PsColors.text400,
                            fontSize: 16,
                          ),
                    )
                  ],
                ),
                if (psValueHolder.selectPriceType != PsConst.NO_PRICE)
                  Container(
                    width: 1,
                    height: 64,
                    color: PsColors.achromatic500,
                  ),
                PriceWidget()
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: PsDimens.space10),
              height: 1,
              color: PsColors.achromatic500,
            ),
            if (product.isSoldOutItem == false)
              Selector<ItemDetailProvider, int?>(
                  selector: (_, ItemDetailProvider provider) =>
                      provider.quantity,
                  builder: (_, int? qty, __) {
                    return (qty == null)
                        ? const SizedBox()
                        : Text(
                            '$qty Items In Stock',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text700
                                        : PsColors.text300,
                                    fontSize: 14),
                          );
                  }),
          ],
        ),
      ),
    );
  }

  bool isPriceEmpty(String? price) {
    return price == null || price == '' || price == '0';
  }
}

class PriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final Product product = itemDetailProvider.product;
    final String? currencySymbol = product.itemCurrency?.currencySymbol ?? '';
    //check whether to show original price or discounted price
    final String? currentPrice =
        product.isDiscountedItem && psValueHolder.isShowDiscount!
            ? product.currentPrice
            : product.originalPrice;
    return Column(
      children: <Widget>[
        if (psValueHolder.selectPriceType == PsConst.NORMAL_PRICE)
          (psValueHolder.hidePriceSetting == PsConst.ONE &&
                  Utils.isLoginUserEmpty(psValueHolder))
              ? Text(
                  '$currencySymbol\t*****',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 21, color: Theme.of(context).primaryColor),
                )
              : Text(
                  isPriceEmpty(currentPrice)
                      ? 'item_price_free'.tr
                      : '$currencySymbol ${Utils.getPriceFormat(currentPrice!, psValueHolder.priceFormat!)}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: PsColors.primary500,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
        if (psValueHolder.selectPriceType == PsConst.NO_PRICE) Container(),
        if (psValueHolder.selectPriceType == PsConst.NORMAL_PRICE)
          if (psValueHolder.selectPriceType == PsConst.PRICE_RANGE)
            PriceDollar(product.originalPrice ?? ''),
        if (psValueHolder.isShowDiscount! &&
            product.isDiscountedItem &&
            psValueHolder.selectPriceType == PsConst.NORMAL_PRICE)
          (psValueHolder.hidePriceSetting == PsConst.ONE &&
                  Utils.isLoginUserEmpty(psValueHolder))
              ? const SizedBox()
              : Text(
                  //original price
                  '$currencySymbol ${Utils.getPriceFormat(product.originalPrice ?? '', psValueHolder.priceFormat!)}',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      overflow: TextOverflow.ellipsis,
                      color: Utils.isLightMode(context)
                          ? PsColors.text500
                          : PsColors.primary500,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 16),
                )
      ],
    );
  }

  bool isPriceEmpty(String? price) {
    return price == null || price == '' || price == '0';
  }
}

class LocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final Product product = itemDetailProvider.product;

    /** UI Section is here */
    return Container(
      // margin: const EdgeInsets.only(
      //         top: PsDimens.space12,
      //         left: PsDimens.space16,
      //         right: PsDimens.space16),
      child: Consumer<ItemEntryFieldProvider>(builder: (BuildContext context,
          ItemEntryFieldProvider provider, Widget? child) {
        if (provider.hasData) {
          const String itemAddress = 'ps-itm00032';
          final int addressIndex = product.productRelation!.indexWhere(
              (ProductRelation element) => element.coreKeyId == itemAddress);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  if (psValueHolder.isUseGoogleMap!) {
                    await Navigator.pushNamed(context, RoutePaths.googleMapPin,
                        arguments: MapPinIntentHolder(
                            flag: PsConst.VIEW_MAP,
                            mapLat: product.lat,
                            mapLng: product.lng));
                  } else {
                    await Navigator.pushNamed(context, RoutePaths.mapPin,
                        arguments: MapPinIntentHolder(
                            flag: PsConst.VIEW_MAP,
                            mapLat: product.lat,
                            mapLng: product.lng));
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Remix.map_pin_line,
                          color: Utils.isLightMode(context)
                              ? PsColors.achromatic500
                              : PsColors.achromatic400,
                          size: 24,
                        ),
                        const SizedBox(
                          width: PsDimens.space8,
                        ),
                        if (addressIndex < 0 ||
                            product.productRelation
                                    ?.elementAt(addressIndex)
                                    .selectedValues?[0]
                                    .value ==
                                '')
                          Container(
                            width: PsDimens.space150,
                            // color: Colors.deepOrangeAccent,
                            child: Text(
                              product.itemLocationTownship!.townshipName !=
                                          null &&
                                      product.itemLocationTownship!
                                              .townshipName! !=
                                          ''
                                  ? product.itemLocation!.name! +
                                      ', ' +
                                      product
                                          .itemLocationTownship!.townshipName!
                                  : product.itemLocation!.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text500
                                        : PsColors.text400,
                                    fontSize: 16,
                                  ),
                            ),
                          )
                        else
                          Container(
                            width: PsDimens.space150,
                            child: Text(
                              product.productRelation
                                      ?.elementAt(addressIndex)
                                      .selectedValues?[0]
                                      .value ??
                                  '',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Utils.isLightMode(context)
                                        ? PsColors.text500
                                        : PsColors.text400,
                                    fontSize: 16,
                                  ),
                              maxLines: 2,
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else
          return const SizedBox();
      }),
    );
  }
}
