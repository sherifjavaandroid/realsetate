import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/ps_colors.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/added_item_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/item_list_intent_holder.dart';

class OtherUserItemCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final AddedItemProvider addedItemProvider =
        Provider.of<AddedItemProvider>(context);
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RoutePaths.userItemList,
              arguments: ItemListIntentHolder(
                  userId: userProvider.user.data!.userId,
                  status: '1',
                  title: 'profile__listing'.tr));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: PsDimens.space12),
          child: Column(
            children: <Widget>[
              Text(
                addedItemProvider.itemList.data!.length.toString(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.text600
                        : PsColors.text100),
                maxLines: 1,
              ),
              Text(
                'profile__listing'.tr,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.text600
                        : PsColors.text100),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
