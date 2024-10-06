import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/vendor/provider/vendor_application/vendor_user_detail_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../custom_ui/user/user_vendor_detail/component/detail_info/widgets/other_user_vendor_banner_photo.dart';

class OtherUserVendorDetailWidget extends StatefulWidget {
  const OtherUserVendorDetailWidget({
    Key? key,
    this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  State<OtherUserVendorDetailWidget> createState() =>
      _OtherUserStoreDetailWidgetState();
}

class _OtherUserStoreDetailWidgetState
    extends State<OtherUserVendorDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final Animation<double>? animation =
        curveAnimation(widget.animationController!);
//  final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Consumer<VendorUserDetailProvider>(builder: (BuildContext context,
        VendorUserDetailProvider provider, Widget? child) {
      if (provider.vendorUserDetail.data != null) {
        widget.animationController!.forward();
        return AnimatedBuilder(
            animation: widget.animationController!,
            child: CustomOtherUserVendorBannerPhoto(),
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                  opacity: animation!,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 100 * (1.0 - animation.value), 0.0),
                      child: child));
            });
      } else {
        return const SizedBox();
      }
    });
  }
}
