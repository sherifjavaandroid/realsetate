import 'package:flutter/material.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';

class SelectedNavItemWidget extends StatelessWidget {
  const SelectedNavItemWidget({required this.icon});
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            //  color: Utils.isLightMode(context)
            //     ? PsColors.mainColor
            //     : Colors.black54,
            borderRadius: BorderRadius.circular(PsDimens.space12),
            // shape: BoxShape.rectangle,
            // color: PsColors.mainColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
      ],
    );
  }
}
