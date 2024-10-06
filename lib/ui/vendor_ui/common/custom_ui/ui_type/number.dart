import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';
import '../../ps_textfield_widget.dart';

class NumberWidget extends StatelessWidget {
  const NumberWidget({Key? key, required this.customField}) : super(key: key);
  final CustomField customField;

  @override
  Widget build(BuildContext context) {
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);
    final MapEntry<CustomField, SelectedObject> element = itemEntryFieldProvider
        .textControllerMap.entries
        .firstWhere((MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == customField.coreKeyId);

    return PsTextFieldWidget(
        titleText: customField.name!.tr,
        keyboardType: TextInputType.number,
        textAboutMe: false,
        hintText: customField.placeHolder!.tr,
        textEditingController: element.value.valueTextController,
        isStar: customField.coreKeyId == 'ps-itm00046' &&
            itemEntryFieldProvider.selectedVendorId != PsConst.USER_PROFILE

        // customField.isMandatory,
        );
  }
}
