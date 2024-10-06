import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import 'map_for_flutter.dart';
import 'map_for_google.dart';

class MapWiget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space16,
            right: PsDimens.space16,
            top: PsDimens.space24,
            bottom: PsDimens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('item_entry__location'.tr,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Utils.isLightMode(context)
                          ? PsColors.accent500
                          : PsColors.primary300,
                    )),
            const SizedBox(
              height: PsDimens.space12,
            ),
            Container(
              height: 186,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.all(Radius.circular(PsDimens.space12)),
                child: valueHolder.isUseGoogleMap!
                    ? const MapForGoogle()
                    : const MapForFlutter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
