import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../config/route/route_paths.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/paystack_intent_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../vendor_ui/item/promote/component/promote/ad_how_many_day/widgets/demo_warning_dialog.dart';

class PayStackButton extends StatelessWidget {
  const PayStackButton({
    //required this.getEnterDateCountController,
    required this.product,
    required this.amount,
    required this.howManyDay,
    required this.selectedDate,
    required this.selectedTime,
    required this.provider,
    required this.appProvider,
    required this.userProvider,
  });
  // final TextEditingController getEnterDateCountController;
  final Product product;
  final String howManyDay;
  final String amount;
  final String selectedDate;
  final DateTime selectedTime;
  final ItemPromotionProvider? provider;
  final AppInfoProvider? appProvider;
  final UserProvider? userProvider;

  @override
  Widget build(BuildContext context) {
    String? chooseDay;
    chooseDay = howManyDay;

    String? startDate;
    startDate = selectedDate;

    DateTime? time;
    time = selectedTime;
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Container(
      margin: const EdgeInsets.only(
          top: PsDimens.space8,
          left: PsDimens.space16,
          right: PsDimens.space16),
      width: double.infinity,
      child: InkWell(
        onTap: () async {
          // final AppInfoProvider appProvider =
          //     Provider.of<AppInfoProvider>(context, listen: false);
          // final UserProvider userProvider =
          //     Provider.of<UserProvider>(context, listen: false);
          // final ItemPromotionProvider provider =
          //     Provider.of<ItemPromotionProvider>(context, listen: false);
          if (double.parse(amount) <= 0) {
            return;
          }

          if (psValueHolder.isDemoForPayment!) {
            await callDemoWarningDialog(context);
          }
          final int resultStartTimeStamp =
              Utils.getTimeStampDividedByOneThousand(time!);

          final dynamic returnData = await Navigator.pushNamed(
              context, RoutePaths.payStackPayment,
              arguments: PayStackInterntHolder(
                  product: product,
                  amount: amount,
                  howManyDay: chooseDay,
                  paymentMethod: PsConst.PAYMENT_PAY_STACK_METHOD,
                  stripePublishableKey:
                      appProvider!.appInfo.data!.stripePublishableKey,
                  startDate: startDate,
                  startTimeStamp: resultStartTimeStamp.toString(),
                  itemPaidHistoryProvider: provider!,
                  userProvider: userProvider!,
                  payStackKey: appProvider!.appInfo.data!.payStackKey));

          if (returnData == null || returnData) {
            Navigator.pop(context, true);
            Navigator.of(context).pop(true);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        width: 62,
                        height: 62,
                        child:
                            Image.asset('assets/images/payment/paystack.png')),
                    const SizedBox(
                      height: 2,
                    )
                  ],
                ),
                const SizedBox(width: PsDimens.space16),
                Text(
                  'item_promote__pay_stack'.tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.text800
                          : PsColors.achromatic50),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Utils.isLightMode(context)
                  ? PsColors.text800
                  : PsColors.achromatic50,
            )
          ],
        ),
      ),
    );
  }
}
