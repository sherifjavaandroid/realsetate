import 'package:flutter/material.dart';
import '../../../../../vendor_ui/user/user_vendor_detail/component/vendor_info_list/vendor_profile_view.dart';

class CustomVendorProfileView extends StatefulWidget {
  @override
  State<CustomVendorProfileView> createState() => _VendorProfileViewState();
}

class _VendorProfileViewState extends State<CustomVendorProfileView> {
  @override
  Widget build(BuildContext context) {
    return VendorProfileView();
  }
}
