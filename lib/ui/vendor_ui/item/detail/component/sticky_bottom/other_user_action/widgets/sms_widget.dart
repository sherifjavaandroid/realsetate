import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../common/ps_button_widget_with_round_corner.dart';

class SMSWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);
    final List<String> phoneList =
        provider.product.phoneNumList?.split('#') ?? <String>[];
    phoneList.removeWhere((String phone) => phone == '');
    if (provider.productOwner!.showPhone && provider.productOwner!.hasPhone) {
      phoneList.insert(0, provider.productOwner!.userPhone!);
    }
    final Product product = provider.product;
    return Padding(
      padding:
          const EdgeInsets.only(left: PsDimens.space8, right: PsDimens.space8),
      child: PSButtonWidgetWithIconRoundCorner(
        width: psValueHolder.selectChatType != PsConst.NO_CHAT
            ? PsDimens.space40
            : MediaQuery.of(context).size.width / 2.5,
        // colorData: Utils.isLightMode(context) ? PsColors.achromatic50  : PsColors.text800,
        colorData: (product.vendorUser!.isVendorUser &&
                product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI)
            ? PsColors.achromatic100
            : Theme.of(context).primaryColor,

        borderColor: (product.vendorUser!.isVendorUser &&
                product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI)
            ? PsColors.achromatic500
            : PsColors.primary500,
        hasShadow: false,
        icon: Remix.message_2_line,
        iconColor: (product.vendorUser!.isVendorUser &&
                product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI)
            ? PsColors.achromatic500
            // : PsColors.primary500,
            : Utils.isLightMode(context)
                ? PsColors.text50
                : PsColors.text800,
        onPressed: () async {
          // if (provider.productOwner!.hasPhone) {
          //   if (await canLaunchUrl(
          //       Uri.parse('sms://${provider.productOwner!.userPhone}'))) {
          //     await launchUrl(
          //         Uri.parse('sms://${provider.productOwner!.userPhone}'));
          //   } else {
          //     throw 'Could not send Phone Number 1';
          //   }
          // } else if (provider.product.phoneNumList != '')
          if (product.vendorUser!.isVendorUser &&
              product.vendorUser?.expiredStatus == PsConst.EXPIRED_NOTI) {
            // ignore: unnecessary_statements
            null;
          } else {
            showModalBottomSheet<Widget>(
                elevation: 2.0,
                isScrollControlled: true,
                useRootNavigator: true,
                isDismissible: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.0)),
                ),
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: phoneList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: PsDimens.space16),
                                child: InkWell(
                                  onTap: () async {
                                    if (await canLaunchUrl(Uri.parse(
                                        'sms://${phoneList[index]}'))) {
                                      await launchUrl(Uri.parse(
                                          'sms://${phoneList[index]}'));
                                    } else {
                                      throw 'Could not send Phone Number 1';
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        phoneList.elementAt(index),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.normal),
                                      ),
                                      Icon(Remix.message_2_line,
                                          size: 25,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        PSButtonWithIconWidget(
                          colorData: Theme.of(context).primaryColor,
                          hasShadow: false,
                          // icon: Icons.call,
                          iconColor: PsColors.achromatic50,
                          width: double.infinity,
                          titleText: 'cancel'.tr,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
