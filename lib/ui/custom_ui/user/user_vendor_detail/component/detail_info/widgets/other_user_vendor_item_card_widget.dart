import 'package:flutter/material.dart';
import '../../../../../../vendor_ui/user/user_vendor_detail/component/detail_info/widgets/other_user_vendor_item_card_widget.dart';

class CustomOtherUserVendorItemCardWidget extends StatelessWidget {
  const CustomOtherUserVendorItemCardWidget({Key? key, required this.isLoading})
      : super(key: key);
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return OtherUserVendorItemCardWidget(
      isLoading: isLoading,
    );
  }
}
