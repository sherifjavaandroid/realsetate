import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class OtherUserVendorJoinDateTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VendorUserDetailProvider provider =
        Provider.of<VendorUserDetailProvider>(context);
    if (provider.hasData) {
      return Column(
        children: <Widget>[
          Text(
            provider.vendorUserDetail.data?.addedDate == ''
                ? ''
                : Utils.getDateFormat(
                    provider.vendorUserDetail.data?.addedDate, 'dd/MM/yyyy'),
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
            maxLines: 1,
          ),
          Text(
            'vendor_joined_date'.tr,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            maxLines: 1,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
