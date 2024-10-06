import 'package:flutter/material.dart';
import '../../../../../vendor_ui/dashboard/components/home/widgets/header_card.dart';

class CustomHeaderCard extends StatelessWidget {
  const CustomHeaderCard({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    return HeaderCard(
      animationController: animationController,
    );
  }
}
