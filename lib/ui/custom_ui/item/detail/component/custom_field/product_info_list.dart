import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/detail/component/custom_detail_info/product_info_list.dart';

class CustomProductInfoListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductInfoWidgetState();
}

class _ProductInfoWidgetState extends State<CustomProductInfoListWidget> {
  @override
  Widget build(BuildContext context) {
    return ProductInfoWidget();
  }
}
