import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import 'demo_warning_dialog.dart';

class FlutterwaveButton extends StatelessWidget {
  const FlutterwaveButton({
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

    return Container(
      margin: const EdgeInsets.only(
          top: PsDimens.space8,
          left: PsDimens.space16,
          right: PsDimens.space16),
      width: double.infinity,
      child: InkWell(
        onTap: () async {
          final PsValueHolder psValueHolder =
              Provider.of<PsValueHolder>(context, listen: false);

          if (double.parse(amount) <= 0) {
            return;
          }
          print('Payapl amount :::::::::::::::' + amount);

          if (psValueHolder.isDemoForPayment!) {
            await callDemoWarningDialog(context);
          }

          final int reultStartTimeStamp =
              Utils.getTimeStampDividedByOneThousand(time!);




          // ignore: unnecessary_null_comparison
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
                        child: Image.asset(
                          'assets/images/payment/flutterwave.png',
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(
                      height: 2,
                    )
                  ],
                ),
                const SizedBox(width: PsDimens.space16),
                Text(
                  'item_promote__flutterwave'.tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic800
                          : PsColors.achromatic50),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic800
                  : PsColors.achromatic50,
            )
          ],
        ),
      ),
    );
  }
}
