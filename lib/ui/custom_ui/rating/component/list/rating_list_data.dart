import 'package:flutter/material.dart';
import '../../../../vendor_ui/rating/component/list/rating_list_data.dart';

class CustomRatingListData extends StatelessWidget {
  const CustomRatingListData({Key? key, required this.itemUserId})
      : super(key: key);
  final String itemUserId;

  @override
  Widget build(BuildContext context) {
    return RatingListData(itemUserId: itemUserId);
  }
}
