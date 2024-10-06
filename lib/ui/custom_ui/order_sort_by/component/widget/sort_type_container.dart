import 'package:flutter/material.dart';

import '../../../../vendor_ui/order_sort_by/component/widget/sort_type_container.dart';

class CustomSortTypeContainer extends StatelessWidget {
  const CustomSortTypeContainer({Key? key,this.onTap,required this.sortTypeText}) : super(key: key);
  final String sortTypeText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SortTypeContainer(sortTypeText: sortTypeText,onTap: onTap,);
  }
}