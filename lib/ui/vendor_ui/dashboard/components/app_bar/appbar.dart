import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../vendor_ui/common/ps_ui_widget.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar(
      {required this.appBarTitle,
      required this.appBarTitleName,
      required this.currentIndex,
      required this.updateCurrentIndex,
      required this.userProvider});
  final String appBarTitle;
  final String appBarTitleName;
  final int? currentIndex;
  final Function updateCurrentIndex;
  final UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    final bool hideAppbar = (Utils.showFavoriteProduct(currentIndex) &&
            !Utils.isLoginUserEmpty(valueHolder)) ||
        Utils.showPopularProductView(currentIndex) ||
        Utils.showFeaturedProductView(currentIndex) ||
        Utils.showNotificationsView(currentIndex) ||
        Utils.showProfileView(currentIndex, valueHolder);

    if (hideAppbar) {
      return const SizedBox();
    }
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        appBarTitleName == '' ? appBarTitle : appBarTitleName,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: Utils.isLightMode(context)
                ? PsColors.achromatic900
                : PsColors.achromatic50),
      ),
      titleSpacing: 0,
      elevation: 0,
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      // iconTheme: IconThemeData(
      //     color: (appBarTitle == 'home__verify_email'.tr ||
      //             appBarTitle == 'home_verify_phone'.tr)
      //         ? PsColors.mainColor
      //         : PsColors.buttonColor),
      titleTextStyle: const TextStyle(
          fontFamily: PsConst.ps_default_font_family,
          fontWeight: FontWeight.bold,
          fontSize: 18),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Utils.isLightMode(context)
            ? PsColors.achromatic50
            : PsColors.achromatic800,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
      ),
      actions: Utils.showHomeDashboardView(currentIndex)
          ? <Widget>[
              IconButton(
                icon: Icon(Remix.map_pin_line,
                    size: 25, color: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.itemLocationList,
                  );
                },
              ),
              //CustomAppbarNotiIcon(),
              // if (valueHolder.vendorFeatureSetting == PsConst.ONE &&
              //     valueHolder.checkoutFeatureOn == PsConst.ONE)
              //   const SizedBox()
              // //  CustomAppbarShoppingCartIcon()
              // else
              //   CustomAppbarNotiIcon(),

              // if(userProvider.user.data != null && userProvider.user.data!.userCoverPhoto != '' )
              if (!Utils.isLoginUserEmpty(valueHolder))
                InkWell(
                  onTap: () {
                    // if (!Utils.isLoginUserEmpty(valueHolder)) {
                    updateCurrentIndex(
                      'home__menu_drawer_profile'.tr,
                      PsConst.REQUEST_CODE__MENU_USER_PROFILE_FRAGMENT,
                    );
                    // } else {
                    //   updateCurrentIndex('home__menu_drawer_profile'.tr,
                    //       PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT,);
                    // }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: PsDimens.space8,
                      left: PsDimens.space4,
                      right: PsDimens.space4,
                      top: PsDimens.space8,
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      child: PsNetworkCircleImageForUser(
                        photoKey: '',
                        imagePath: userProvider.user.data?.userCoverPhoto ?? '',
                        boxfit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              else
                IconButton(
                  icon: const Icon(
                    Icons.person,
                  ),
                  onPressed: () {
                    if (!Utils.isLoginUserEmpty(valueHolder)) {
                      updateCurrentIndex(
                        'home__menu_drawer_profile'.tr,
                        PsConst.REQUEST_CODE__MENU_USER_PROFILE_FRAGMENT,
                      );
                    } else {
                      updateCurrentIndex(
                        'home__menu_drawer_profile'.tr,
                        PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT,
                      );
                    }
                  },
                ),
              const SizedBox(
                width: 8,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
