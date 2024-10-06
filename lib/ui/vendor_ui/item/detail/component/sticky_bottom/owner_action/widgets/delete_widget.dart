import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../config/route/route_paths.dart';
import '../../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/user_delete_item_parameter_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../../common/ps_button_widget_with_round_corner.dart';

class DeleteItemWidget extends StatefulWidget {
  @override
  DeleteItemWidgetState<DeleteItemWidget> createState() =>
      DeleteItemWidgetState<DeleteItemWidget>();
}

class DeleteItemWidgetState<T extends DeleteItemWidget>
    extends State<DeleteItemWidget> {
  late ItemDetailProvider provider;
  late Product product;
  late PsValueHolder psValueHolder;
  late AppInfoProvider appInfoProvider;
  bool showDeleteIcon = true;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ItemDetailProvider>(context);
    appInfoProvider = Provider.of<AppInfoProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    product = provider.product;
    // showDeleteIcon = !product.isSoldOutItem ||
    //     (product.isItemPromotable && !appInfoProvider.isAllPaymentDisable);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: PSButtonWidgetWithIconRoundCorner(
        //  colorData: Utils.isLightMode(context) ? PsColors.achromatic50  : PsColors.text800,
        colorData: (product.vendorUser!.isVendorUser &&
                product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI)
            ? PsColors.achromatic100
            : Utils.isLightMode(context)
                ? PsColors.achromatic50
                : PsColors.text800,

        borderColor: (product.vendorUser!.isVendorUser &&
                product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI)
            ? PsColors.achromatic500
            : PsColors.primary500,
        width: showDeleteIcon
            ? PsDimens.space40
            : MediaQuery.of(context).size.width - 34,
        hasShadow: false,
        icon: Remix.delete_bin_6_line,
        iconColor: (product.vendorUser!.isVendorUser &&
                product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI)
            ? PsColors.achromatic500
            : PsColors.primary500,
        onPressed: () {
          product.vendorUser!.isVendorUser &&
                  product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI
              // ignore: unnecessary_statements
              ? null
              : onDeleteItem();
        },
      ),
    );
  }

  Future<void> onDeleteItem() async {
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialogView(
              title: 'Confirmation'.tr,
              description: 'item_detail__delete_desc'.tr,
              cancelButtonText: 'dialog__cancel'.tr,
              confirmButtonText: 'logout_dialog__confirm'.tr,
              onAgreeTap: () async {
                final UserDeleteItemParameterHolder
                    userDeleteItemParameterHolder =
                    UserDeleteItemParameterHolder(
                  itemId: provider.product.id,
                );
                await PsProgressDialog.showDialog(context);
                final PsResource<ApiStatus> _apiStatus =
                    await provider.userDeleteItem(
                        userDeleteItemParameterHolder.toMap(),
                        psValueHolder.loginUserId!,
                        langProvider.currentLocale.languageCode,
                        provider.product.id!);
                PsProgressDialog.dismissDialog();
                if (_apiStatus.status == PsStatus.SUCCESS) {
                  await provider.deleteLocalProductCacheById(
                      provider.product.id, psValueHolder.loginUserId);
                  Fluttertoast.showToast(
                      msg: _apiStatus.data?.message ?? 'Item Deleted',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: PsColors.info300,
                      textColor: PsColors.achromatic50);
                  // Navigator.pop(context, true);
                  Navigator.pushReplacementNamed(
                    context,
                    RoutePaths.home,
                  );
                } else {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: _apiStatus.message != ''
                          ? _apiStatus.message
                          : 'Item is not Deleted',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: PsColors.info200,
                      textColor: PsColors.achromatic50);
                }
              });
        });
  }
}
