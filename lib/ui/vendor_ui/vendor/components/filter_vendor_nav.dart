import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/vendor/search_vendor_provider.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/holder/vendor_search_parameter_holder.dart';
import '../../../vendor_ui/common/dialog/filter_dialog.dart';

class FilterVendorNav extends StatelessWidget {
  const FilterVendorNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorSearchProvider _vendorSearchVendor =
        Provider.of<VendorSearchProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(
          right: PsDimens.space10, bottom: PsDimens.space10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return FilterDialog(
                      onAscendingTap: () async {
                        final VendorSearchParameterHolder getAsc =
                            VendorSearchParameterHolder().getAsc();
                        _vendorSearchVendor.loadDataList(
                            reset: true, requestBodyHolder: getAsc);
                      },
                      onDescendingTap: () {
                        final VendorSearchParameterHolder getDesc =
                            VendorSearchParameterHolder().getDesc();
                        _vendorSearchVendor.loadDataList(
                            reset: true, requestBodyHolder: getDesc);
                      },
                    );
                  });
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.sort_by_alpha_outlined,
                    color: Utils.isLightMode(context)
                        ? PsColors.primary500
                        : PsColors.achromatic50,
                    size: 24,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Text('Sort'.tr,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 16,
                            color: Utils.isLightMode(context)
                                ? PsColors.achromatic900
                                : PsColors.achromatic50,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
