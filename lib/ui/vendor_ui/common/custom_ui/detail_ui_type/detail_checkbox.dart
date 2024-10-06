import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';

class DetailCheckBoxWidget extends StatefulWidget {
  const DetailCheckBoxWidget({
    Key? key,
    required this.customField,
  }) : super(key: key);
  final CustomField customField;

  @override
  State<DetailCheckBoxWidget> createState() => _DetailCheckBoxWidgetState();
}

class _DetailCheckBoxWidgetState extends State<DetailCheckBoxWidget> {
  // bool? _isSelected = false;
  late MapEntry<CustomField, SelectedObject> element;

  // void _handleOnChange(bool? value) {
  // setState(() {
  //   // _isSelected = value;
  //   if (value == true) {
  //     element.value.valueTextController.text = PsConst.ONE;
  //   } else {
  //     element.value.valueTextController.text = PsConst.ZERO;
  //   }
  // });
  // }

  @override
  Widget build(BuildContext context) {
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);
    element = itemEntryFieldProvider.textControllerMap.entries.firstWhere(
        (MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == widget.customField.coreKeyId);

    if (element.value.valueTextController.text.isEmpty) {
      element.value.valueTextController.text = PsConst.ZERO;
    }

    if (element.value.valueTextController.text == PsConst.ONE)
      return Container(
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
                child: Icon(
                  Icons.circle,
                  size: 4,
                  color: Utils.isLightMode(context)
                          ? PsColors.primary100
                          : Theme.of(context).primaryColor
                ),
              ),
            ),
            Flexible(
              child: Text(
                widget.customField.name!,
                maxLines: 30,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: PsColors.achromatic500,
                      fontSize: 18,
                    ),
              ),
            ),
          ],
        ),
      );
    else {
      return const SizedBox();
    }
  }
}
