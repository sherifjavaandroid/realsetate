import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../config/ps_colors.dart';

import '../../../../../../../../config/route/route_paths.dart';
import '../../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/item_change_status_parameter_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../../common/ps_button_widget.dart';

class ChangeStatusWidget extends StatefulWidget {
  @override
  ChangeStatusWidgetState<ChangeStatusWidget> createState() =>
      ChangeStatusWidgetState<ChangeStatusWidget>();
}

class ChangeStatusWidgetState<T extends ChangeStatusWidget>
    extends State<ChangeStatusWidget> {
  late ItemDetailProvider provider;
  late Product product;
  late PsValueHolder psValueHolder;
  late bool isAccpeptedItem;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    provider = Provider.of<ItemDetailProvider>(context);
    product = provider.product;
    isAccpeptedItem = product.status == PsConst.ONE;
    return Expanded(
      child: Container(
        margin: Directionality.of(context) == TextDirection.rtl
            ? const EdgeInsets.only(left: PsDimens.space16)
            : const EdgeInsets.only(right: PsDimens.space16),
        child: PSButtonWidget(
          textColor: (product.vendorUser!.isVendorUser &&
                  product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI)
              ? PsColors.text500
              : Utils.isLightMode(context)
                  ? PsColors.text50
                  : PsColors.text800,
          hasShadow: false,
          width: MediaQuery.of(context).size.width,
          colorData: product.vendorUser!.isVendorUser &&
                  product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI
              // PsConst.EXPIRED_NOTI
              ? PsColors.achromatic100
              : Theme.of(context).primaryColor,
          titleText: isAccpeptedItem
              ? 'item_detail_disable'.tr
              : 'item_detail_enable'.tr,
          onPressed: () {
            product.vendorUser!.isVendorUser &&
                    product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI
                // ignore: unnecessary_statements
                ? null
                : onChangeItemStatus();
          },
        ),
      ),
    );
  }

  Future<void> onChangeItemStatus() async {
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialogView(
              title: isAccpeptedItem
                  ? 'item_detail_make_disable'.tr
                  : 'item_detail_make_eable'.tr,
              description: isAccpeptedItem
                  ? 'item_detail_make_disable_desc'.tr
                  : 'item_detail_make_eable_desc'.tr,
              cancelButtonText: 'dialog__cancel'.tr,
              confirmButtonText: 'new_psw_create_done'.tr,
              onAgreeTap: () async {
                final ItemChangeStatusParameterHolder holder =
                    ItemChangeStatusParameterHolder(
                        itemId: product.id,
                        status: isAccpeptedItem
                            ? PsConst.STATUS_DISABLE
                            : PsConst.STATUS_ACCEPT);
                await PsProgressDialog.showDialog(context);
                final PsResource<Product> _apiStatus =
                    await provider.changeItemStatus(
                        holder.toMap(),
                        psValueHolder.loginUserId!,
                        langProvider.currentLocale.languageCode,
                        provider.product.id!);

                if (_apiStatus.status == PsStatus.SUCCESS) {
                  if (isAccpeptedItem) {
                    PsProgressDialog.dismissDialog();
                    await provider.deleteLocalProductCacheById(
                        provider.product.id, psValueHolder.loginUserId);
                    Navigator.pushReplacementNamed(
                      context,
                      RoutePaths.home,
                    );
                  } else {
                    await provider.loadData(
                        requestPathHolder: RequestPathHolder(
                            itemId: product.id,
                            loginUserId:
                                Utils.checkUserLoginId(psValueHolder)));
                    PsProgressDialog.dismissDialog();
                    Navigator.pop(context);
                  }
                } else {
                  Navigator.pop(context);
                }
              });
        });
  }
}
