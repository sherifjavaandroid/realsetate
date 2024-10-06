import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/favourite_item_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/favourite_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/dialog/error_dialog.dart';

class SaveWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaveWidgetState();
}

class _SaveWidgetState extends State<SaveWidget> {
  late PsValueHolder psValueHolder;
  late ItemDetailProvider itemDetailProvider;
  late FavouriteItemProvider favouriteItemProvider;
  String? loginUserId = '';
  late Product product;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    itemDetailProvider = Provider.of<ItemDetailProvider>(context);
    favouriteItemProvider = Provider.of<FavouriteItemProvider>(context);
    loginUserId = Utils.checkUserLoginId(psValueHolder);
    product = itemDetailProvider.product;

    return InkWell(
      onTap: onFavoriteClick,
      child: Container(
        padding: const EdgeInsets.all(PsDimens.space10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: PsColors.achromatic50,
        ),
        child: Icon(
          product.isFavorite ? Remix.bookmark_fill : Remix.bookmark_line,
          size: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Future<void> onFavoriteClick() async {
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    if (await Utils.checkInternetConnectivity()) {
      Utils.navigateOnUserVerificationView(context, () async {
        if (product.isFavorite) {
          setState(() {
            itemDetailProvider.product.isFavourited = '0';
          });
        } else {
          setState(() {
            itemDetailProvider.product.isFavourited = '1';
          });
        }

        final FavouriteParameterHolder favouriteParameterHolder =
            FavouriteParameterHolder(
          userId: loginUserId,
          itemId: itemDetailProvider.product.id,
        );
        await favouriteItemProvider.postFavourite(
            favouriteParameterHolder.toMap(),
            loginUserId!,
            psValueHolder.headerToken!,
            langProvider.currentLocale.languageCode);
      });
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'error_dialog__no_internet'.tr,
            );
          });
    }
  }
}
