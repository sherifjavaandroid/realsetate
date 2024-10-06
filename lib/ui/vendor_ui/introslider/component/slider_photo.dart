import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../custom_ui/introslider/component/dot/dot_list.dart';
import '../../../custom_ui/introslider/component/explore_button.dart';
import '../../../custom_ui/introslider/component/next_button.dart';
import '../../../custom_ui/introslider/component/not_show_again_widget.dart';

class SliderPhoto extends StatelessWidget {
  const SliderPhoto({
    required this.orientation, 
    required this.currentIndex,
    required this.nextButtonClick,
    required this.sliderPageCount,
    required this.fromSettingSlider
    });
  final Orientation orientation;
  final int currentIndex;
  final Function nextButtonClick;
  final int sliderPageCount;
  final bool fromSettingSlider;
  
  @override
  Widget build(BuildContext context) {
    final List<String> pictureList = <String>[
      'assets/images/slider_1.svg',
      'assets/images/slider_2.svg',
      'assets/images/slider_3.svg'
    ];

    if (orientation == Orientation.portrait)
      return Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2 * 2.5,
            margin: const EdgeInsets.only(
              left: PsDimens.space12,
              right: PsDimens.space12,
              bottom: PsDimens.space8),
            child: ClipRRect(
              borderRadius:
                BorderRadius.circular(PsDimens.space32),
              child: SvgPicture.asset(
                pictureList[currentIndex],
                fit:BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 4.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomDotList(
                  orientation: Orientation.portrait,
                  currentIndex: currentIndex),
                if (currentIndex < sliderPageCount - 1)  
                CustomNextButton(onTap: nextButtonClick),
                if (currentIndex < sliderPageCount - 1)
                  const SizedBox(height: 48),
                if (currentIndex == sliderPageCount - 1)
                  Column(
                    children: <Widget>[
                      CustomExploreButton(
                          fromSettingSlider: fromSettingSlider),
                      CustomNotShowAgainWidget(),
                    ],
                  ),
              ]),
          ),
        ]);
    else
      return Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2 * 2.6,
            margin: const EdgeInsets.only(
              left: PsDimens.space12,
              right: PsDimens.space12,
              bottom: PsDimens.space8),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(PsDimens.space32),
              child: SvgPicture.asset(
                pictureList[currentIndex],
                fit:BoxFit.cover,
              ),
            ),
          ),
           Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 4.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomDotList(
                  orientation: Orientation.portrait,
                  currentIndex: currentIndex),
                if (currentIndex < sliderPageCount - 1)  
                CustomNextButton(onTap: nextButtonClick),
                if (currentIndex < sliderPageCount - 1)
                  const SizedBox(height: 48),
                if (currentIndex == sliderPageCount - 1)
                  Column(
                    children: <Widget>[
                      CustomExploreButton(
                          fromSettingSlider: fromSettingSlider),
                      CustomNotShowAgainWidget(),
                    ],
                  ),
              ]),
          ),
        ]);
  }
}
