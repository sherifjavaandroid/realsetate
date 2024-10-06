import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../custom_ui/item/detail/component/sticky_bottom/buy_action/buy_action.dart';
import '../../../../../custom_ui/item/detail/component/sticky_bottom/other_user_action/other_user_actions_widget.dart';
import '../../../../../custom_ui/item/detail/component/sticky_bottom/owner_action/owner_actions_widget.dart';

class StickyBottomWidget extends StatelessWidget {
  const StickyBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    // final AppInfoProvider appInfoProvider =
    //     Provider.of<AppInfoProvider>(context);
    final Product product = itemDetailProvider.product;

    return (!itemDetailProvider.productOwner!.hasPhone &&
            itemDetailProvider.product.phoneNumList == '' &&
            psValueHolder.selectChatType == PsConst.NO_CHAT)
        ? Container()
        : Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: PsDimens.space84,
              decoration: BoxDecoration(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic50
                    : PsColors.text800,
                border: Border.all(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic50
                      : PsColors.text800,
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(PsDimens.space12),
                    topRight: Radius.circular(PsDimens.space12)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic50
                        : PsColors.text800,
                    blurRadius: 10.0, // has the effect of softening the shadow
                    spreadRadius: 0, // has the effect of extending the shadow
                    offset: const Offset(
                      0.0, // horizontal, move right 10
                      0.0, // vertical, move down 10
                    ),
                  )
                ],
              ),
              child: Utils.isOwnerItem(psValueHolder, product)
                  ? CustomOwnerActionButtonsWidget()
                  : (itemDetailProvider.product.vendorId != '' &&
                          psValueHolder.vendorFeatureSetting == PsConst.ONE &&
                          psValueHolder.checkoutFeatureOn == PsConst.ONE)
                      ? const CustomBuyAction()
                      // : (itemDetailProvider.product.vendorId != '' &&
                      //         appInfoProvider.appInfo.data?.vendorConFig
                      //                 ?.vendorCheckoutSetting ==
                      //             PsConst.ONE)
                      //     ? const CustomBuyAction()
                      : CustomOtherUserActionsWidget(),
            ),
          );
  }
}
