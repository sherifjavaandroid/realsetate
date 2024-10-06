import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../../core/vendor/viewobject/product.dart';

class AmenitiesWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AmenitiesWidgetState();
}

class _AmenitiesWidgetState extends State<AmenitiesWidget> {
  List<CustomField> customFieldList = <CustomField>[];
  String amenity = 'ps-itm00033';
  String amenityValue = '';
  CustomField amenityCustomField = CustomField(visible: '0');

  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final Product product = itemDetailProvider.product;

    return SliverToBoxAdapter(
      child: Consumer<ItemEntryFieldProvider>(builder: (BuildContext context,
          ItemEntryFieldProvider provider, Widget? child) {
        amenityCustomField = provider.getCustomFieldByCoreKeyId(amenity);
        if (amenityCustomField.isVisible)
          amenityValue = product.selectedValuesOfProductRelation(amenity);

        final List<String> amenities = amenityValue.split(',');
        amenities.remove('');
        if (amenityValue != '' && amenities.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.only(
                left: PsDimens.space16,
                right: PsDimens.space16,
                top: PsDimens.space12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('item_detail_amenity'.tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Utils.isLightMode(context)
                              ? PsColors.accent500
                              : PsColors.primary300,
                        )),
                Container(
                  height: 46,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: PsDimens.space12),
                      scrollDirection: Axis.horizontal,
                      itemCount: amenities.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FacilitiesWidgetItem(data: amenities[index]);
                      }),
                ),
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
  const FacilitiesWidgetItem({required this.data});

  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: PsDimens.space12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PsDimens.space50),
          color:
              Utils.isLightMode(context) ? PsColors.text100 : PsColors.text800),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 16.0),
        child: IntrinsicWidth(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Remix.arrow_right_circle_line,
                size: 24,
                color: PsColors.primary500,
              ),
              const SizedBox(
                width: PsDimens.space8,
              ),
              Expanded(
                child: Text(data,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          color: Utils.isLightMode(context)
                              ? PsColors.accent500
                              : PsColors.primary300,
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
