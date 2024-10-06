import 'package:flutter/material.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../vendor_ui/offer/component/widgets/sent/offer_sent_list_data.dart';

class CustomOfferSentListData extends StatefulWidget {
  const CustomOfferSentListData(
      {required this.animationController, required this.psValueHolder});
  final AnimationController animationController;
  final PsValueHolder psValueHolder;
  @override
  State<StatefulWidget> createState() => _OfferSentListDataView();
}

class _OfferSentListDataView extends State<CustomOfferSentListData> {
  @override
  Widget build(BuildContext context) {
    return OfferSentListData(
        psValueHolder: widget.psValueHolder,
        animationController: widget.animationController);
  }
}
