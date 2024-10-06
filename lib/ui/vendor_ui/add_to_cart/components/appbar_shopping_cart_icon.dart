import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';

class AppbarShoppingCartIcon extends StatelessWidget {
  const AppbarShoppingCartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Consumer<AddToCartProvider>(
      builder: (BuildContext context, AddToCartProvider addToCartProvider,
          Widget? child) {
        return InkWell(
          onTap: () {
            Utils.navigateOnUserVerificationView(context, () async {
              final dynamic result =
                  await Navigator.pushNamed(context, RoutePaths.addToCart);
              if (result != null) {
                addToCartProvider.loadData(
                    dataConfig: DataConfiguration(
                        dataSourceType: DataSourceType.SERVER_DIRECT),
                    requestPathHolder: RequestPathHolder(
                        isCheckoutPage: PsConst.ZERO,
                        loginUserId: psValueHolder.loginUserId,
                        languageCode: psValueHolder.languageCode));
              }
            });
          },
          child: badges.Badge(
            badgeStyle: badges.BadgeStyle(
              shape: BadgeShape.circle,
              badgeColor: PsColors.primary500,
              padding: const EdgeInsets.all(5),
              borderRadius: BorderRadius.circular(4),
            ),
            position: BadgePosition.topEnd(top: 4, end: 3),
            badgeContent: Text(
                '${addToCartProvider.hasData ? addToCartProvider.shoppingCart.data?.items?.length : '0'}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: PsColors.primary50,
                    fontWeight: FontWeight.w400,
                    fontSize: PsDimens.space16)),
            child: Container(
              width: PsDimens.space44,
              child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.shopping_bag_outlined,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
