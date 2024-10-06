import 'package:flutter/material.dart';

import '../../../vendor_ui/introslider/component/slider_photo.dart';

class CustomSliderPhoto extends StatelessWidget {
  const CustomSliderPhoto({
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
    return SliderPhoto(
      orientation: orientation, 
      currentIndex: currentIndex,
      nextButtonClick: nextButtonClick,
      sliderPageCount: sliderPageCount,
      fromSettingSlider: fromSettingSlider);
  }
}
