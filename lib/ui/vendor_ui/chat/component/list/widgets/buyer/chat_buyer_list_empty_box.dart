import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/vendor_list.dart';
import '../../../../../common/ps_button_widget.dart';

class ChatBuyerListEmptyBox extends StatefulWidget {
  @override
  State<ChatBuyerListEmptyBox> createState() => _ChatBuyerListEmptyBoxState();
}

class _ChatBuyerListEmptyBoxState extends State<ChatBuyerListEmptyBox> {
  late PsValueHolder psValueHolder;

  late UserProvider provider;

  late AppLocalization langProvider;

  late ItemEntryFieldProvider itemEntryFieldProvider;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    provider = Provider.of<UserProvider>(context);
    langProvider = Provider.of<AppLocalization>(context);
    itemEntryFieldProvider = Provider.of<ItemEntryFieldProvider>(context);

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: PsDimens.space145,
              ),
              SvgPicture.asset(
                'assets/images/chat_list_empty_photo.svg',
              ),
              const SizedBox(
                height: PsDimens.space16,
              ),
              Text('You currently have no message'.tr,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Utils.isLightMode(context)
                          ? PsColors.text800
                          : PsColors.text50)),
              const SizedBox(
                height: PsDimens.space8,
              ),
              Text('Upload your items to market and sell easily.'.tr,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.text400
                          : PsColors.text50)),
              if (isUserValid)
                Container(
                  margin: const EdgeInsets.all(PsDimens.space16),
                  child: PSButtonWidget(
                    titleText: 'Start Selling'.tr,
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePaths.entryCategoryList,
                          arguments: true);
                    },
                  ),
                ),
            ]),
      ),
    );
  }

  bool get isUserHasVendor {
    final List<VendorList> vendorList =
        itemEntryFieldProvider.itemEntryField.data?.vendorList ??
            <VendorList>[];
    if (psValueHolder.loginUserId == '1') {
      return true;
    } else if (vendorList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool get isUserValid {
    //allow all users, if logined or not
    if (psValueHolder.uploadSetting == PsConst.UPLOAD_SETTING_ALL) {
      return true;
    } else {
      if (Utils.isLoginUserEmpty(psValueHolder)) {
        //login user is empty, don't show item-add button
        return false;
      } else {
        /*load user data*/
        if (provider.hasData &&
            provider.data.data!.userId != psValueHolder.loginUserId) {
          provider.getUser(psValueHolder.loginUserId ?? '',
              langProvider.currentLocale.languageCode);
        }

        //only admin and bluemark users are allowed
        if (psValueHolder.uploadSetting ==
            PsConst.UPLOAD_SETTING_ADMIN_AND_BLUEMARK) {
          return provider.hasData &&
              (provider.user.data!.roleId == PsConst.ONE ||
                  provider.user.data!.isVefifiedBlueMarkUser);
        }
        //only admin is allowed
        else if (psValueHolder.uploadSetting ==
            PsConst.UPLOAD_SETTING_ONLY_ADMIN) {
          return provider.hasData && provider.user.data!.roleId == PsConst.ONE;
        } else if (psValueHolder.uploadSetting == 'vendor-only') {
          return isUserHasVendor;
        } else {
          return false;
        }
      }
    }
  }
}
