import 'package:flutter/material.dart';
import '../../../../../vendor_ui/dashboard/components/bottom_nav/widgets/noti_nav_item.dart';

class CustomNotiNavCount extends StatefulWidget {
  const CustomNotiNavCount({required this.updateSelectedIndexWithAnimation});
  final Function updateSelectedIndexWithAnimation;

  @override
  State<StatefulWidget> createState() =>
      NotiNavCountState<CustomNotiNavCount>();
}

class NotiNavCountState<T extends CustomNotiNavCount>
    extends State<CustomNotiNavCount> {
  @override
  Widget build(BuildContext context) {
    return NotiNavCount(
      updateSelectedIndexWithAnimation: widget.updateSelectedIndexWithAnimation,
    );
  }
}
