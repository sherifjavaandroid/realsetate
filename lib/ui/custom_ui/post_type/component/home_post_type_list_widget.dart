import 'package:flutter/material.dart';
import '../../../vendor_ui/post_type/component/home_post_type_list_widget.dart';

class CustomHomePostTypeHorizontalListWidget extends StatelessWidget {
  const CustomHomePostTypeHorizontalListWidget(
      {Key? key, required this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    return HomePostTypeHorizontalListWidget(
      animationController: animationController,
    );
  }
}
