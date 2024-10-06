import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../config/ps_colors.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';

class DetailMultiSelectionWidget extends StatelessWidget {
  const DetailMultiSelectionWidget({Key? key, required this.customField})
      : super(key: key);
  final CustomField customField;

  @override
  Widget build(BuildContext context) {
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);
    final MapEntry<CustomField, SelectedObject> element = itemEntryFieldProvider
        .textControllerMap.entries
        .firstWhere((MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == customField.coreKeyId);
    final List<String> multiSelectValues =
        element.value.valueTextController.text.split(',');

    // multiSelectValues.add('Power Steering');
    // multiSelectValues.add('Voltage');
    // multiSelectValues.add('Solor');
    // multiSelectValues.add('Electronic Devices');

    return Visibility(
      visible: element.value.valueTextController.text.isNotEmpty &&
          multiSelectValues.isNotEmpty,
      child: Container(
        margin: const EdgeInsets.only(
          top: PsDimens.space8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 24,
              height: 24,
              child: Center(
                child: Icon(Icons.circle,
                    size: 4,
                    color: Utils.isLightMode(context)
                        ? PsColors.primary100
                        : Theme.of(context).primaryColor),
              ),
            ),
            Flexible(
              child: Text(
                multiSelectValues.join(', '),
                maxLines: 30,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.primary100
                          : Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailMultiSelectItem extends StatelessWidget {
  const DetailMultiSelectItem({Key? key, required this.value})
      : super(key: key);
  final String value;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
          right: PsDimens.space6,
          top: PsDimens.space2,
          bottom: PsDimens.space2),
      child: Padding(
        padding: const EdgeInsets.only(
            left: PsDimens.space8, right: PsDimens.space8),
        child: Center(
          child: Text(
            value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
