import 'package:flutter/material.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';

class DotList extends StatelessWidget {
  const DotList({required this.orientation, required this.currentIndex});
  final Orientation orientation;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    const Widget activeDot = Dot(
      isActive: true,
    );
    const Widget inactiveDot = InactiveDot(
      isActive: false,
    );
    return Container(
      margin: (orientation == Orientation.portrait)
          ? const EdgeInsets.only(top: PsDimens.space10)
          : const EdgeInsets.only(bottom: PsDimens.space10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (currentIndex == 0) activeDot else inactiveDot,
          if (currentIndex == 1) activeDot else inactiveDot,
          if (currentIndex == 2) activeDot else inactiveDot
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 46.0,
        padding: const EdgeInsets.only(
            left: PsDimens.space2, right: PsDimens.space2),
        child: MaterialButton(
          height: 7.0,
          color: isActive ? PsColors.primary500 : PsColors.achromatic200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          onPressed: () {},
        ));
  }
}

class InactiveDot extends StatelessWidget {
  const InactiveDot({required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 35.0,
        padding: const EdgeInsets.only(
            left: PsDimens.space2, right: PsDimens.space2),
        child: MaterialButton(
          height: 7.0,
          color: isActive ? PsColors.primary500 : PsColors.primary200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          onPressed: () {},
        ));
  }
}
