import 'package:flutter/material.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../vendor_ui/offer/component/widgets/received/offer_receive_list_data.dart';

class CustomOfferReceivedListData extends StatefulWidget {
  const CustomOfferReceivedListData(
      {required this.animationController, required this.psValueHolder});
  final AnimationController animationController;
  final PsValueHolder psValueHolder;
  @override
  State<StatefulWidget> createState() => _OfferReceivedListViewState();
}

class _OfferReceivedListViewState extends State<CustomOfferReceivedListData> {
  @override
  Widget build(BuildContext context) {
    return OfferReceivedListData(
        psValueHolder: widget.psValueHolder,
        animationController: widget.animationController);
  }
}
