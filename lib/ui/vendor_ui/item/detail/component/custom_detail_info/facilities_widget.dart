import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../../core/vendor/viewobject/product.dart';

class FacilitiesWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FacilitiesWidgetState();
}

class _FacilitiesWidgetState extends State<FacilitiesWidget> {
  List<CustomField> customFieldList = <CustomField>[];
  String sqft = 'ps-itm00034';
  String sqftValue = '';
  CustomField sqftCustomField = CustomField(visible: '0');

  String floor = 'ps-itm00039';
  String floorValue = '';
  CustomField floorCustomField = CustomField(visible: '0');

  String bed = 'ps-itm00035';
  String bedValue = '';
  CustomField bedCustomField = CustomField(visible: '0');

  String bath = 'ps-itm00036';
  String bathValue = '';
  CustomField bathCustomField = CustomField(visible: '0');

  String kitchen = 'ps-itm00037';
  String kitchenValue = '';
  CustomField kitchenCustomField = CustomField(visible: '0');

  String wifi = 'ps-itm00038';
  String wifiValue = '';
  CustomField wifiCustomField = CustomField(visible: '0');

  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final Product product = itemDetailProvider.product;
    return SliverToBoxAdapter(
      child: Consumer<ItemEntryFieldProvider>(builder: (BuildContext context,
          ItemEntryFieldProvider provider, Widget? child) {
        sqftCustomField = provider.getCustomFieldByCoreKeyId(sqft);
        if (sqftCustomField.isVisible)
          sqftValue = product.selectedValuesOfProductRelation(sqft);

        floorCustomField = provider.getCustomFieldByCoreKeyId(floor);
        if (floorCustomField.isVisible)
          floorValue = product.selectedValuesOfProductRelation(floor);

        bedCustomField = provider.getCustomFieldByCoreKeyId(bed);
        if (bedCustomField.isVisible)
          bedValue = product.selectedValuesOfProductRelation(bed);

        bathCustomField = provider.getCustomFieldByCoreKeyId(bath);
        if (bathCustomField.isVisible)
          bathValue = product.selectedValuesOfProductRelation(bath);

        kitchenCustomField = provider.getCustomFieldByCoreKeyId(kitchen);
        if (kitchenCustomField.isVisible)
          kitchenValue = product.selectedValuesOfProductRelation(kitchen);

        wifiCustomField = provider.getCustomFieldByCoreKeyId(wifi);
        if (wifiCustomField.isVisible)
          wifiValue = product.selectedValuesOfProductRelation(wifi);

        if (int.tryParse(sqftValue) != null ||
            int.tryParse(floorValue) != null ||
            int.tryParse(bedValue) != null ||
            int.tryParse(bathValue) != null ||
            int.tryParse(kitchenValue) != null ||
            wifiValue == PsConst.ONE) {
          final Size size = MediaQuery.of(context).size;
          if (size.height > size.width) {}

          return Container(
            margin: const EdgeInsets.only(
                left: PsDimens.space16,
                right: PsDimens.space16,
                top: PsDimens.space24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('item_detail_facility'.tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Utils.isLightMode(context)
                              ? PsColors.accent500
                              : PsColors.primary300,
                        )),
                GridView(
                    padding: const EdgeInsets.only(top: 0),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          MediaQuery.sizeOf(context).width * 0.39,
                      childAspectRatio:
                          MediaQuery.sizeOf(context).width * 0.0042,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      if (sqftValue != '' && int.tryParse(sqftValue) != null)
                        FacilitiesWidgetItem(
                          icon: Remix.ruler_line,
                          data: sqftValue + ' sqft',
                        ),
                      if (floorValue != '' && int.tryParse(floorValue) != null)
                        FacilitiesWidgetItem(
                            icon: Remix.building_line,
                            data: '$floorValue ' +
                                (int.parse(floorValue) > 1
                                    ? 'item_detail_floors'.tr
                                    : 'item_detail_floor'.tr)),
                      if (bedValue != '' && int.tryParse(bedValue) != null)
                        FacilitiesWidgetItem(
                            icon: Remix.hotel_bed_line,
                            data: '$bedValue ' +
                                (int.parse(bedValue) > 1
                                    ? 'item_detail_beds'.tr
                                    : 'item_detail_bed'.tr)),
                      if (bathValue != '' && int.tryParse(bathValue) != null)
                        FacilitiesWidgetItem(
                            icon: Remix.hand_sanitizer_line,
                            data: '$bathValue ' +
                                (int.parse(bathValue) > 1
                                    ? 'item_detail_baths'.tr
                                    : 'item_detail_bath'.tr)),
                      if (kitchenValue != '' &&
                          int.tryParse(kitchenValue) != null)
                        FacilitiesWidgetItem(
                            icon: Remix.fridge_line,
                            data: '$kitchenValue ' +
                                (int.parse(kitchenValue) > 1
                                    ? 'item_detail_kitchens'.tr
                                    : 'item_detail_kitchen'.tr)),
                      if (wifiValue != '' && wifiValue == PsConst.ONE)
                        FacilitiesWidgetItem(
                            icon: Remix.wifi_line, data: 'item_detail_wifi'.tr),
                    ]),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class FacilitiesWidgetItem extends StatelessWidget {
  const FacilitiesWidgetItem({this.icon, required this.data});

  final IconData? icon;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Utils.isLightMode(context)
                ? PsColors.primary50
                : PsColors.primary200,
          ),
          padding: const EdgeInsets.all(PsDimens.space6),
          child: Icon(
            icon,
            size: 22,
            color: PsColors.primary500,
          ),
        ),
        const SizedBox(
          width: PsDimens.space6,
        ),
        Flexible(
          child: Text(data,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    color: Utils.isLightMode(context)
                        ? PsColors.text800
                        : PsColors.text400,
                  )),
        )
      ],
    );
  }
}
