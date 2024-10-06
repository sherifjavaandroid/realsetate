import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import '../../repository/order_history_repository.dart';
import '../../viewobject/holder/order_history_parameter_holder.dart';
import '../../viewobject/order_history.dart';
import '../common/ps_provider.dart';

class OrderHistoryProvider extends PsProvider<OrderHistory> {
  OrderHistoryProvider({
    required BuildContext context,
  }) : super(initRepo(context), 0,
            subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);
  static OrderHistoryRepository initRepo(BuildContext context) {
    return OrderHistoryRepository(
      psApiService: Provider.of<PsApiService>(context, listen: false),
    );
  }

  String _sortBy = 'order_sort_most_recent'.tr;
  String get sortBy => _sortBy;
  set sortBy(String val) {
    _sortBy = val;
    notifyListeners();
  }

  final List<OrderHistory> pendingOrderList = <OrderHistory>[];
  final List<OrderHistory> deliveredOrderList = <OrderHistory>[];
  final List<OrderHistory> deliveringOrderList = <OrderHistory>[];
  final List<OrderHistory> approvedOrderList = <OrderHistory>[];

  final OrderHistoryParameterHolder getAllParameterHolder =
      OrderHistoryParameterHolder().getAllParameterHolder();

  final OrderHistoryParameterHolder getOldestAllParameterHolder =
      OrderHistoryParameterHolder().getOldestAllParameterHolder();
  final OrderHistoryParameterHolder getPriceLowToHighAllParameterHolder =
      OrderHistoryParameterHolder().getPriceLowToHighAllParameterHolder();
  final OrderHistoryParameterHolder getPriceHightToLowAllParameterHolder =
      OrderHistoryParameterHolder().getPriceHightToLowAllParameterHolder();

  PsResource<List<OrderHistory>> get orders => super.dataList;
}
