import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/add_to_cart/add_to_cart_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

    return Consumer<AddToCartProvider>(
      builder: (_, AddToCartProvider provider, __) => badges.Badge(
          badgeStyle: badges.BadgeStyle(
            shape: BadgeShape.circle,
            badgeColor: PsColors.primary500,
            padding: const EdgeInsets.all(5),
            borderRadius: BorderRadius.circular(4),
          ),
          position: BadgePosition.topEnd(
              top: Directionality.of(context) == TextDirection.ltr ? 3 : 2,
              end: Directionality.of(context) == TextDirection.ltr ? 5 : 15),
          badgeContent: Text(
              '${provider.hasData ? provider.shoppingCart.data?.items?.length : '0'}',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: PsColors.primary50,
                  fontWeight: FontWeight.w400,
                  fontSize: PsDimens.space16)),
          child: Container(
              margin: const EdgeInsets.only(left: PsDimens.space12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PsColors.achromatic900.withAlpha(100),
              ),
              child: Theme(
                  data: Theme.of(context).copyWith(
                      iconTheme: Theme.of(context)
                          .iconTheme
                          .copyWith(color: PsColors.achromatic50)),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined),
                    onPressed: () {
                      Utils.navigateOnUserVerificationView(context, () {
                        Navigator.pushNamed(context, RoutePaths.addToCart)
                            .then((dynamic value) {
                          if (value) {
                            provider.loadData(
                                requestPathHolder: RequestPathHolder(
                                    isCheckoutPage: PsConst.ZERO,
                                    loginUserId: valueHolder.loginUserId,
                                    languageCode: valueHolder.languageCode));
                          }
                        });
                      });
                    },
                  )))),
    );
  }
}
