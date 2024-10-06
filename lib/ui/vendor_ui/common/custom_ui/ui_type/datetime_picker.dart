import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';
import '../../date_time_picker_with_icon.dart';

class DateTimePickerWidget extends StatefulWidget {
  const DateTimePickerWidget({Key? key, required this.customField})
      : super(key: key);
  final CustomField customField;

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);
    final MapEntry<CustomField, SelectedObject> element = itemEntryFieldProvider
        .textControllerMap.entries
        .firstWhere((MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == widget.customField.coreKeyId);

    return Padding(
      padding: const EdgeInsets.only(top: PsDimens.space12),
      child: PsDateTimePickerWithIconWidget(
          iconData: Icons.calendar_month,
          title: widget.customField.name!.tr,
          textEditingController: element.value.valueTextController,
          hintText: widget.customField.placeHolder!.tr,
          isStar: true,
          onTap: () async {
            await DatePicker.showDateTimePicker(
              context,
              minTime: DateTime.now(),
              onConfirm: (DateTime date) {
                setState(() {
                  element.value.valueTextController.text =
                      DateFormat.yMMMMd('en_US').format(date);
                });
              },
              locale: LocaleType.en,
            );
          }),
    );
  }
}
