import 'package:flutter/material.dart';

import '../../../vendor_ui/noti/view/noti_list_menu_container_view.dart';

class CustomNotiListMenuContainerView extends StatefulWidget {
  const CustomNotiListMenuContainerView({
    Key? key,
    required this.scaffoldKey,
    required this.title,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;

  @override
  State<CustomNotiListMenuContainerView> createState() =>
      _CustomNotiListMenuContainerViewState();
}

class _CustomNotiListMenuContainerViewState
    extends State<CustomNotiListMenuContainerView> {
  @override
  Widget build(BuildContext context) {
    return NotiListMenuContainerView(
      scaffoldKey: widget.scaffoldKey,
      title: widget.title,
    );
  }
}
