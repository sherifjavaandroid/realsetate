import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/order_hostory/order_history_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';

class OrdersTabBarView extends StatelessWidget {
  const OrdersTabBarView({
    Key? key,
    required this.widget,
  }) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final OrderHistoryProvider orderHistoryProvider =
        Provider.of<OrderHistoryProvider>(context);
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);

    return Padding(
      padding: const EdgeInsets.all(PsDimens.space12),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              final dynamic data = await Navigator.pushNamed(
                context,
                RoutePaths.orderSortBy,
              );
              if (data != null) {
                if (data == '3') {
                  orderHistoryProvider.sortBy = 'order_price_low_to_high'.tr;
                  orderHistoryProvider.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: Utils.checkUserLoginId(psValueHolder),
                          languageCode:
                              langProvider.currentLocale.languageCode),
                      requestBodyHolder: orderHistoryProvider
                          .getPriceLowToHighAllParameterHolder);
                } else if (data == '2') {
                  orderHistoryProvider.sortBy = 'order_price_high_to_low'.tr;

                  orderHistoryProvider.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: Utils.checkUserLoginId(psValueHolder),
                          languageCode:
                              langProvider.currentLocale.languageCode),
                      requestBodyHolder: orderHistoryProvider
                          .getPriceHightToLowAllParameterHolder);
                } else if (data == '1') {
                  orderHistoryProvider.sortBy = 'order_sort_oldest'.tr;
                  orderHistoryProvider.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: Utils.checkUserLoginId(psValueHolder),
                          languageCode:
                              langProvider.currentLocale.languageCode),
                      requestBodyHolder:
                          orderHistoryProvider.getOldestAllParameterHolder);
                }
                if (data == '0') {
                  orderHistoryProvider.sortBy = 'order_sort_most_recent'.tr;
                  orderHistoryProvider.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: Utils.checkUserLoginId(psValueHolder),
                          languageCode:
                              langProvider.currentLocale.languageCode),
                      requestBodyHolder:
                          orderHistoryProvider.getAllParameterHolder);
                }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.sort, color: PsColors.primary600),
                Text(orderHistoryProvider.sortBy,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 12))
              ],
            ),
          ),
          Expanded(child: widget),
        ],
      ),
    );
  }
}
