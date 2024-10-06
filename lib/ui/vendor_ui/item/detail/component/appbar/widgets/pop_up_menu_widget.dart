import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/user_report_item_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../common/dialog/error_dialog.dart';

class PopUpMenuWidget extends StatefulWidget {
  const PopUpMenuWidget();
  @override
  PopUpMenuWidgetState<PopUpMenuWidget> createState() =>
      PopUpMenuWidgetState<PopUpMenuWidget>();
}

class PopUpMenuWidgetState<T extends PopUpMenuWidget>
    extends State<PopUpMenuWidget> {
  late ItemDetailProvider itemDetailProvider;
  late PsValueHolder psValueHolder;
  late UserProvider userProvider;
  late String loginUserId;
  late Product currentProduct;
  late AppLocalization langProvider;
  Future<void> _onSelect(String value) async {
    switch (value) {
      case '1':
        final Size size = MediaQuery.of(context).size;
        if (currentProduct.dynamicLink != null) {
          Share.share(
            'Go to App:\n' + currentProduct.dynamicLink!,
            sharePositionOrigin:
                Rect.fromLTWH(0, 0, size.width, size.height / 2),
          );
        }
        break;
      case '2':
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ConfirmDialogView(
                description: 'item_detail__confirm_dialog_report_item'.tr,
                cancelButtonText: 'dialog__cancel'.tr,
                confirmButtonText: 'dialog__ok'.tr,
                onAgreeTap: () async {
                  await PsProgressDialog.showDialog(context);

                  final UserReportItemParameterHolder
                      userReportItemParameterHolder =
                      UserReportItemParameterHolder(
                          itemId: currentProduct.id,
                          reportedUserId:
                              Utils.checkUserLoginId(psValueHolder));

                  final PsResource<ApiStatus> _apiStatus =
                      await userProvider.userReportItem(
                          userReportItemParameterHolder.toMap(),
                          Utils.checkUserLoginId(psValueHolder));

                  if (_apiStatus.status == PsStatus.SUCCESS) {
                    await itemDetailProvider.deleteLocalProductCacheById(
                        currentProduct.id,
                        Utils.checkUserLoginId(psValueHolder));
                    PsProgressDialog.dismissDialog();
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(RoutePaths.home));
                  } else {
                    Navigator.pop(context);
                    PsProgressDialog.dismissDialog();
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(message: _apiStatus.message);
                        });
                  }
                });
          },
        );

        break;

      default:
        print('English');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    itemDetailProvider = Provider.of<ItemDetailProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    langProvider = Provider.of<AppLocalization>(context);
    currentProduct = itemDetailProvider.product;
    loginUserId = Utils.checkUserLoginId(psValueHolder);

    /**UI Section is here */
    return Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space12, right: PsDimens.space12),
        child: Theme(
          data: Theme.of(context).copyWith(
              iconTheme: Theme.of(context)
                  .iconTheme
                  .copyWith(color: PsColors.achromatic50)),
          child: PopupMenuButton<String>(
            constraints: const BoxConstraints(maxWidth: PsDimens.space140),
            icon: Icon(
              Remix.more_2_line,
              color: PsColors.primary500,
              size: 26,
            ),
            onSelected: _onSelect,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: '1',
                  child: Text('item_detail__share'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Theme.of(context).primaryColor)),
                ),
                if (!Utils.isOwnerItem(psValueHolder, currentProduct))
                  PopupMenuItem<String>(
                    value: '2',
                    child: Text(
                      'item_detail__report_item'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
              ];
            },
            elevation: 4,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ));
  }
}
