import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../../core/vendor/viewobject/product.dart';

class ProductInfoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductInfoWidgetState();
}

class _ProductInfoWidgetState extends State<ProductInfoWidget> {
  List<CustomField> customFieldList = <CustomField>[];
  String estate = 'ps-itm00031'; //shop owner
  String estateValue = '';
  CustomField estateCustomField = CustomField(visible: '0');

  String postType = 'ps-itm00002';
  String postTypeValue = '';
  CustomField postTypeCustomField = CustomField(visible: '0');

  String priceType = 'ps-itm00003';
  String priceTypeValue = '';
  CustomField priceTypeCustomField = CustomField(visible: '0');

  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final Product product = itemDetailProvider.product;
    return SliverToBoxAdapter(
      child: Consumer<ItemEntryFieldProvider>(builder: (BuildContext context,
          ItemEntryFieldProvider provider, Widget? child) {
        estateCustomField = provider.getCustomFieldByCoreKeyId(estate);
        if (estateCustomField.isVisible)
          estateValue = product.selectedValuesOfProductRelation(estate);

        postTypeCustomField = provider.getCustomFieldByCoreKeyId(postType);
        if (postTypeCustomField.isVisible)
          postTypeValue = product.selectedValuesOfProductRelation(postType);

        priceTypeCustomField = provider.getCustomFieldByCoreKeyId(priceType);
        if (priceTypeCustomField.isVisible)
          priceTypeValue = product.selectedValuesOfProductRelation(priceType);

        return Container(
          height: 32,
          margin: const EdgeInsets.only(
            left: PsDimens.space16, top: PsDimens.space16),
          child: ListView(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ProductInfoWidgetItem(
                  data: product.category?.catName ?? '',
                ),
                if (estateValue != PsConst.ONE)
                  const ProductInfoWidgetItem(data: 'Single Estate'),
                if (postTypeValue != '')
                  ProductInfoWidgetItem(data: postTypeValue),
                if (priceTypeValue != '')
                  ProductInfoWidgetItem(data: priceTypeValue),
              ]),
        );
      }),
    );
  }
}

class ProductInfoWidgetItem extends StatelessWidget {
  const ProductInfoWidgetItem({required this.data});

  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: PsDimens.space8),
      decoration: BoxDecoration(
        color: Utils.isLightMode(context) ? PsColors.primary50 : PsColors.primary200, //PsColors.primary50,
        borderRadius: BorderRadius.circular(PsDimens.space4),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Center(
        child: Text(
          data,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Utils.isLightMode(context) ? PsColors.primary400 : PsColors.primary500,
                fontSize: 16,
              ),
        ),
      ),
    );
  }
}
