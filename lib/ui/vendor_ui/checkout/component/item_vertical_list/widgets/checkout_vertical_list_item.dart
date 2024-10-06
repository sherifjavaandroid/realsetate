import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/add_to_cart_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/shopping_cart_item.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/ps_ui_widget.dart';
import '../../../../item/detail/component/sticky_bottom/buy_action/widgets/quantity_widget.dart';

class CheckoutVerticalListItem extends StatefulWidget {
  const CheckoutVerticalListItem(
      {Key? key,
      required this.shoppingCartItem,
      required this.vendorId,
      required this.isSingleItemCheckout,
      required this.isVendorExpired,
      required this.index})
      : super(key: key);
  final ShoppingCartItem shoppingCartItem;
  final String vendorId;
  final bool isSingleItemCheckout;
  final int isVendorExpired;
  final int index;

  @override
  State<CheckoutVerticalListItem> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<CheckoutVerticalListItem> {
  late AddToCartProvider addToCartProvider;
  late PsValueHolder psValueHolder;
  Timer? _timer;
  int? count;

  @override
  Widget build(BuildContext context) {
    addToCartProvider = Provider.of<AddToCartProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    count ??= int.parse(widget.shoppingCartItem.quantity.toString());
    final int quantity = int.parse(widget.shoppingCartItem.quantity.toString());
    final int availableQuantity =
        int.parse(widget.shoppingCartItem.availableQuantity.toString());
    final bool isSoldOut = widget.shoppingCartItem.isSoldOut == '1' ||
        widget.isVendorExpired == PsConst.EXPIRED_NOTI;

    final AddToCartParameterHolder jsonMap = AddToCartParameterHolder(
        vendorId: widget.vendorId,
        itemId: widget.shoppingCartItem.itemId,
        quantity: '0',
        userId: psValueHolder.loginUserId,
        isSelect: '1');

    return IgnorePointer(
      ignoring: isSoldOut,
      child: Card(
        elevation: 0.2,
        color: Utils.isLightMode(context)
            ? PsColors.achromatic50
            : PsColors.achromatic700,
        margin: EdgeInsets.only(
            left: PsDimens.space8,
            right: (Directionality.of(context) == TextDirection.ltr)
                ? PsDimens.space8
                : 0,
            bottom: PsDimens.space8),
        child: Container(
          width: double.maxFinite,
          height: 130,
          padding: EdgeInsets.only(
              top: PsDimens.space8,
              left: (Directionality.of(context) == TextDirection.ltr)
                  ? 0
                  : PsDimens.space8,
              right: PsDimens.space8,
              bottom: PsDimens.space8),
          child: Row(children: <Widget>[
            /// Image
            ClipRRect(
              borderRadius: BorderRadius.circular(PsDimens.space6),
              child: PsNetworkImage(
                photoKey: widget.shoppingCartItem.itemId,
                defaultPhoto: widget.shoppingCartItem.defaultPhoto,
                imageAspectRation: PsConst.Aspect_Ratio_3x,
                width: PsDimens.space100,
                height: PsDimens.space100,
                boxfit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: PsDimens.space8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /// Item Name
                    Text(
                      widget.shoppingCartItem.itemName ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: isSoldOut
                              ? PsColors.text400
                              : Utils.isLightMode(context)
                                  ? PsColors.text600
                                  : PsColors.text100),
                    ),

                    if (availableQuantity <= 10 &&
                        widget.shoppingCartItem.isSoldOut != '1')
                      Text(
                        'Only $availableQuantity Items In Stock',
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: PsColors.error500,
                                overflow: TextOverflow.ellipsis),
                      ),

                    /// Sold out
                    if (widget.shoppingCartItem.isSoldOut == '1')
                      Text(
                        'dashboard__sold_out'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: PsColors.error500),
                      ),

                    const Spacer(),

                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            if (quantity > 1) {
                              if (widget.isSingleItemCheckout) {
                                final int qty = quantity - 1;
                                addToCartProvider.addSingleItemCheckoutItem(
                                    ShoppingCartItem(
                                        itemId: widget.shoppingCartItem.itemId,
                                        itemName:
                                            widget.shoppingCartItem.itemName,
                                        availableQuantity: widget
                                            .shoppingCartItem.availableQuantity,
                                        defaultPhoto: widget
                                            .shoppingCartItem.defaultPhoto,
                                        discountPrice: widget
                                            .shoppingCartItem.discountPrice,
                                        originalPrice: widget
                                            .shoppingCartItem.originalPrice,
                                        quantity: qty.toString(),
                                        salePrice:
                                            widget.shoppingCartItem.salePrice,
                                        subTotal:
                                            widget.shoppingCartItem.subTotal,
                                        vendorCurrencySymbol: widget
                                            .shoppingCartItem
                                            .vendorCurrencySymbol,
                                        isSoldOut: '0'));
                              } else {
                                if (count != null) {
                                  count = count! - 1;
                                }
                                addToCartProvider.decreaseCount(widget.index);
                                jsonMap.quantity =
                                    widget.shoppingCartItem.quantity;
                                if (_timer != null) {
                                  _timer!.cancel();
                                }
                                _timer = Timer(
                                    const Duration(milliseconds: 1500), () {
                                  _addToCart(jsonMap.toMap());
                                });
                              }
                            }
                          },
                          child: QuantityWidget(
                              icon: Icons.remove,
                              color: (quantity <= 1 || isSoldOut)
                                  ? Utils.isLightMode(context)
                                      ? PsColors.achromatic100
                                      : PsColors.achromatic600
                                  : PsColors.primary500),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PsDimens.space10),
                          child: Text(
                            (addToCartProvider.currentStatus ==
                                        PsStatus.BLOCK_LOADING ||
                                    addToCartProvider.currentStatus ==
                                        PsStatus.PROGRESS_LOADING)
                                ? count.toString()
                                : quantity.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: isSoldOut
                                        ? PsColors.achromatic400
                                        : Utils.isLightMode(context)
                                            ? PsColors.achromatic800
                                            : PsColors.achromatic200),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (quantity < availableQuantity) {
                              if (widget.isSingleItemCheckout) {
                                final int qty = quantity + 1;
                                addToCartProvider.addSingleItemCheckoutItem(
                                    ShoppingCartItem(
                                        itemId: widget.shoppingCartItem.itemId,
                                        itemName:
                                            widget.shoppingCartItem.itemName,
                                        availableQuantity: widget
                                            .shoppingCartItem.availableQuantity,
                                        defaultPhoto: widget
                                            .shoppingCartItem.defaultPhoto,
                                        discountPrice: widget
                                            .shoppingCartItem.discountPrice,
                                        originalPrice: widget
                                            .shoppingCartItem.originalPrice,
                                        quantity: qty.toString(),
                                        salePrice:
                                            widget.shoppingCartItem.salePrice,
                                        subTotal:
                                            widget.shoppingCartItem.subTotal,
                                        vendorCurrencySymbol: widget
                                            .shoppingCartItem
                                            .vendorCurrencySymbol,
                                        isSoldOut: '0'));
                              } else {
                                if (count != null) {
                                  count = count! + 1;
                                }
                                addToCartProvider.increaseCount(widget.index);
                                jsonMap.quantity =
                                    widget.shoppingCartItem.quantity;
                                if (_timer != null) {
                                  _timer!.cancel();
                                }
                                _timer = Timer(
                                    const Duration(milliseconds: 1500), () {
                                  _addToCart(jsonMap.toMap());
                                });
                              }
                            }
                          },
                          child: QuantityWidget(
                              icon: Icons.add,
                              color:
                                  (quantity >= availableQuantity || isSoldOut)
                                      ? Utils.isLightMode(context)
                                          ? PsColors.achromatic100
                                          : PsColors.achromatic600
                                      : PsColors.primary500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                /// Discount Price
                Text(
                  ' ${widget.shoppingCartItem.vendorCurrencySymbol}${widget.shoppingCartItem.salePrice}',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color:
                          isSoldOut ? PsColors.primary400 : PsColors.primary500,
                      fontSize: 16),
                ),
                if (widget.shoppingCartItem.discountPrice == '0' ||
                    widget.shoppingCartItem.discountPrice == '0.00')
                  const SizedBox()
                else
                  Text(
                    '${widget.shoppingCartItem.vendorCurrencySymbol}${widget.shoppingCartItem.originalPrice}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: isSoldOut
                            ? PsColors.text400
                            : Utils.isLightMode(context)
                                ? PsColors.text500
                                : PsColors.text200,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 14),
                  ),

                const Spacer(),

                if (!widget.isSingleItemCheckout)
                  GestureDetector(
                    onTap: () async {
                      final int itemCartId = int.parse(
                          widget.shoppingCartItem.cartItemId.toString());
                      _deleteShoppingCartItem(<int>[itemCartId]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: PsDimens.space4),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        size: 32,
                        color: Utils.isLightMode(context)
                            ? PsColors.achromatic600
                            : PsColors.achromatic200,
                      ),
                    ),
                  )
              ],
            )
          ]),
        ),
      ),
    );
  }

  Future<void> _addToCart(Map<dynamic, dynamic> jsonMap) async {
    final PsResource<ApiStatus> respone =
        await addToCartProvider.submitAddToCart(context, jsonMap,
            psValueHolder.loginUserId, psValueHolder.languageCode);

    if (respone.status == PsStatus.SUCCESS) {
      addToCartProvider.loadData(
          dataConfig:
              DataConfiguration(dataSourceType: DataSourceType.FULL_CACHE),
          requestPathHolder: RequestPathHolder(
              isCheckoutPage: PsConst.ONE,
              loginUserId: psValueHolder.loginUserId,
              languageCode: psValueHolder.languageCode));
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: respone.message);
          });
    }
  }

  Future<void> _deleteShoppingCartItem(List<int> itemCartList) async {
    await PsProgressDialog.showDialog(context);
    final PsResource<ApiStatus> respone =
        await addToCartProvider.deleteItemFromCart(context, itemCartList,
            psValueHolder.loginUserId, psValueHolder.languageCode);

    if (respone.status == PsStatus.SUCCESS) {
      await addToCartProvider.loadData(
          dataConfig: addToCartProvider.availableShoppingCartList.length == 1
              ? DataConfiguration(dataSourceType: DataSourceType.SERVER_DIRECT)
              : DataConfiguration(dataSourceType: DataSourceType.FULL_CACHE),
          requestPathHolder: RequestPathHolder(
              isCheckoutPage: PsConst.ONE,
              loginUserId: psValueHolder.loginUserId,
              languageCode: psValueHolder.languageCode));

      PsProgressDialog.dismissDialog();
    } else {
      PsProgressDialog.dismissDialog();
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: respone.message);
          });
    }
  }
}
