import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/detail/component/appbar/widgets/edit_widget.dart';

class CustomEditWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends State<CustomEditWidget> {

  @override
  Widget build(BuildContext context) {
    return EditWidget();
  }
}
