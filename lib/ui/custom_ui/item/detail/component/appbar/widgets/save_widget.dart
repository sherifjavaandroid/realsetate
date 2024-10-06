import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/detail/component/appbar/widgets/save_widget.dart';

class CustomSaveWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaveWidgetState();
}

class _SaveWidgetState extends State<CustomSaveWidget> {
  @override
  Widget build(BuildContext context) {
    return SaveWidget();
  }
}
