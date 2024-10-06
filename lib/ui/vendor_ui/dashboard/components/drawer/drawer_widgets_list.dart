import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/delete_task/delete_task_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/delete_task_repository.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/activity_log_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/blog_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/contact_us_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/featured_product_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/header_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/header_with_profile_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/home_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/log_out_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/login_header_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/my_orders_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/notifications_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/popular_product_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/rate_this_app_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/setting_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/share_this_app_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/shopping_cart_menu_widget.dart';
import '../../../../custom_ui/dashboard/components/drawer/widgets/user_offers_menu_widget.dart';

class DrawerWidgetList extends StatefulWidget {
  const DrawerWidgetList(
      {required this.updateSelectedIndexWithAnimation,
      required this.callLogout,
      required this.deleteTaskProvider,
      required this.scaffoldKey});
  final Function updateSelectedIndexWithAnimation;
  final Function callLogout;
  final DeleteTaskProvider deleteTaskProvider;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  DrawerWidgetState<DrawerWidgetList> createState() =>
      DrawerWidgetState<DrawerWidgetList>();
}

class DrawerWidgetState<T extends DrawerWidgetList>
    extends State<DrawerWidgetList> {
  DeleteTaskRepository? deleteTaskRepository;
  UserRepository? userRepository;
  UserProvider? userProvider;
  AppInfoProvider? appInfoProvider;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    appInfoProvider = Provider.of<AppInfoProvider>(context);
    return Drawer(
      child: Consumer2<UserProvider, AppInfoProvider>(
        builder: (BuildContext context, UserProvider provider,
            AppInfoProvider appInfoProvider, Widget? child) {
          print(provider.psValueHolder!.loginUserId);
          /**
             * UI SECTION 
             */
          return ListView(padding: EdgeInsets.zero, children: <Widget>[
            CustomDrawerHeaderWidget(),
            if (!Utils.isLoginUserEmpty(valueHolder))
              CustomDrawerHeaderWidgetWithUserProfile()
            else
              CustomLoginHeaderMenuWidget(
                updateSelectedIndexWithAnimation:
                    widget.updateSelectedIndexWithAnimation,
              ),
            if (!Utils.isLoginUserEmpty(valueHolder))
              const Divider(
                height: PsDimens.space1,
              ),
            CustomHomeMenuWidget(
              updateSelectedIndexWithAnimation:
                  widget.updateSelectedIndexWithAnimation,
            ),
            CustomPopularProductMenuWidget(
              updateSelectedIndexWithAnimation:
                  widget.updateSelectedIndexWithAnimation,
            ),
            CustomFeaturedProductMenuWidget(
              updateSelectedIndexWithAnimation:
                  widget.updateSelectedIndexWithAnimation,
            ),
            if (valueHolder.vendorFeatureSetting == PsConst.ONE &&
                valueHolder.checkoutFeatureOn == PsConst.ONE)
              CustomNotificationsMenuWidget(
                updateSelectedIndexWithAnimation:
                    widget.updateSelectedIndexWithAnimation,
              ),

            if (!Utils.isLoginUserEmpty(valueHolder))
              CustomUserOfferMenuWidget(
                updateSelectedIndexWithAnimation:
                    widget.updateSelectedIndexWithAnimation,
              ),
            const Divider(
              height: PsDimens.space1,
            ),
            if (!Utils.isLoginUserEmpty(valueHolder) &&
                valueHolder.vendorFeatureSetting == PsConst.ONE &&
                valueHolder.checkoutFeatureOn == PsConst.ONE)
              CustomMyOrdersMenuWidget(
                updateSelectedIndexWithAnimation:
                    widget.updateSelectedIndexWithAnimation,
              ),

            // CustomShoppingCartMenuWidget(
            //     updateSelectedIndexWithAnimation:
            //         widget.updateSelectedIndexWithAnimation),

            Visibility(
              visible: appInfoProvider
                          .appInfo.data?.vendorConFig?.vendorCheckoutSetting ==
                      PsConst.ONE &&
                  !Utils.isLoginUserEmpty(valueHolder),
              child: CustomShoppingCartMenuWidget(
                  updateSelectedIndexWithAnimation:
                      widget.updateSelectedIndexWithAnimation),
            ),
            CustomBlogMenuWidget(
              updateSelectedIndexWithAnimation:
                  widget.updateSelectedIndexWithAnimation,
            ),
            if (!Utils.isLoginUserEmpty(valueHolder))
              CustomActivityLogMenuWidget(
                updateSelectedIndexWithAnimation:
                    widget.updateSelectedIndexWithAnimation,
              ),
            const Divider(
              height: PsDimens.space1,
            ),
            CustomSettingMenuWidget(
              updateSelectedIndexWithAnimation:
                  widget.updateSelectedIndexWithAnimation,
            ),
            CustomContactUsMenuWidget(
              updateSelectedIndexWithAnimation:
                  widget.updateSelectedIndexWithAnimation,
            ),
            CustomRateThisAppMenuWidget(),
            CustomShareThisAppMenuWidget(),
            const Divider(
              height: PsDimens.space1,
            ),
            if (!Utils.isLoginUserEmpty(valueHolder))
              CustomLogoutMenuWidget(
                scaffoldKey: widget.scaffoldKey,
                callLogout: widget.callLogout,
                deleteTaskProvider: widget.deleteTaskProvider,
              ),
          ]);
          //);
        },
      ),
      //)
    );
  }
}
