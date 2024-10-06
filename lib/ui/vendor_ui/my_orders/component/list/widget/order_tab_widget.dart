import 'package:flutter/material.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';

class OrderTabWidget extends StatelessWidget {
  const OrderTabWidget({Key? key, this.text}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: PsDimens.space10),
      child: Tab(
        text: text,
      ),
    );
  }
}
