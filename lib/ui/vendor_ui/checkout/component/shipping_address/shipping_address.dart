import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../custom_ui/checkout/component/shipping_address/widgets/shipping_address_widget.dart';

class ShippingAddressView extends StatelessWidget {
  const ShippingAddressView({Key? key, })
      : super(key: key);
  // final ShippingAddressHolder? shippingAddressHolder;
  // final String? productId;
  @override
  Widget build(BuildContext context) {
   return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          Navigator.pop(context, '1');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
          title: Text('user_add_new_address'.tr,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic900
                      : PsColors.achromatic50,
                  fontWeight: FontWeight.w500,
                  fontSize: PsDimens.space18)),
        ),
        body: const CustomShippingAddressWidget(),

      ),
    );
  }
}
