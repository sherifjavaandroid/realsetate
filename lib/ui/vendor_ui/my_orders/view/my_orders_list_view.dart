import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../config/ps_colors.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/provider/order_hostory/order_history_provider.dart';
import '../../../../core/vendor/viewobject/order_history.dart';
import '../../../custom_ui/my_orders/component/list/order_tab_bar_view.dart';
import '../../../custom_ui/my_orders/component/widget/order_item_widget.dart';
import '../../../custom_ui/my_orders/component/widget/order_tab_widget.dart';
import '../../common/ps_ui_widget.dart';

class MyOrdersListView extends StatefulWidget {
  const MyOrdersListView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _MyOrdersListViewState createState() => _MyOrdersListViewState();
}

class _MyOrdersListViewState extends State<MyOrdersListView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late OrderHistoryProvider? orderHistoryProvider;
  late AppLocalization langProvider;
  PsValueHolder? psValueHolder;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        orderHistoryProvider?.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<OrderHistoryProvider?>(
              lazy: false,
              create: (BuildContext context) {
                orderHistoryProvider = OrderHistoryProvider(
                  context: context,
                );

                orderHistoryProvider?.loadDataList(
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder),
                        languageCode: langProvider.currentLocale.languageCode),
                    requestBodyHolder:
                        orderHistoryProvider?.getAllParameterHolder);

                return orderHistoryProvider;
              }),
        ],
        child: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: TabBar(
              tabAlignment: TabAlignment.start,
              labelStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              isScrollable: true,
              labelColor: PsColors.primary500,
              indicatorColor: PsColors.primary500,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: <Widget>[
                CustomOrderTabWidget(text: 'order_all'.tr),
                CustomOrderTabWidget(text: 'order_pending'.tr),
                CustomOrderTabWidget(text: 'order_approved'.tr),
                CustomOrderTabWidget(text: 'order_delivering'.tr),
                CustomOrderTabWidget(text: 'order_delivered'.tr),
              ],
            ),
            body: Consumer<OrderHistoryProvider>(builder: (BuildContext context,
                OrderHistoryProvider value, Widget? child) {
              value.pendingOrderList.clear();
              value.deliveredOrderList.clear();
              value.deliveringOrderList.clear();
              value.approvedOrderList.clear();

              for (OrderHistory item in value.orders.data ?? <OrderHistory>[]) {
                if (item.orderStatus == 'Pending') {
                  value.pendingOrderList.add(item);
                } else if (item.orderStatus == 'Delivered') {
                  value.deliveredOrderList.add(item);
                } else if (item.orderStatus == 'Delivering') {
                  value.deliveringOrderList.add(item);
                } else if (item.orderStatus == 'Approved') {
                  value.approvedOrderList.add(item);
                }
              }
              return Stack(children: <Widget>[
                TabBarView(
                  children: <Widget>[
                    CustomOrdersTabBarView(
                      widget: value.hasData == true
                          ? ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.orders.data?.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          RoutePaths.orderDetail,
                                          arguments: <String, dynamic>{
                                            'orderId':
                                                value.orders.data?[index].id,
                                          });
                                    },
                                    child: CustomOrderItemWidget(
                                      itemCount:
                                          value.orders.data?[index].itemCount,
                                      orderCode:
                                          value.orders.data?[index].orderCode,
                                      orderStatus:
                                          value.orders.data?[index].orderStatus,
                                      paymentDate:
                                          value.orders.data?[index].paymentDate,
                                      total: value.orders.data?[index].total,
                                      orderStatusColor: value
                                          .orders.data?[index].orderStatusColor,
                                      itemInfo:
                                          value.orders.data?[index].itemInfo,
                                    ),
                                  ))
                          : const SizedBox(),
                    ),
                    CustomOrdersTabBarView(
                      widget: value.pendingOrderList.isNotEmpty
                          ? ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.pendingOrderList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          RoutePaths.orderDetail,
                                          arguments: <String, dynamic>{
                                            'orderId': value
                                                .pendingOrderList[index].id,
                                          });
                                    },
                                    child: CustomOrderItemWidget(
                                      itemCount: value
                                          .pendingOrderList[index].itemCount,
                                      orderCode: value
                                          .pendingOrderList[index].orderCode,
                                      orderStatus: value
                                          .pendingOrderList[index].orderStatus,
                                      paymentDate: value
                                          .pendingOrderList[index].paymentDate,
                                      total:
                                          value.pendingOrderList[index].total,
                                      orderStatusColor: value
                                          .pendingOrderList[index]
                                          .orderStatusColor,
                                      itemInfo: value
                                          .pendingOrderList[index].itemInfo,
                                    ),
                                  ))
                          : const SizedBox(),
                    ),
                    CustomOrdersTabBarView(
                      widget: value.approvedOrderList.isNotEmpty
                          ? ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.approvedOrderList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          RoutePaths.orderDetail,
                                          arguments: <String, dynamic>{
                                            'orderId': value
                                                .approvedOrderList[index].id,
                                          });
                                    },
                                    child: CustomOrderItemWidget(
                                      itemCount: value
                                          .approvedOrderList[index].itemCount,
                                      orderCode: value
                                          .approvedOrderList[index].orderCode,
                                      orderStatus: value
                                          .approvedOrderList[index].orderStatus,
                                      paymentDate: value
                                          .approvedOrderList[index].paymentDate,
                                      total:
                                          value.approvedOrderList[index].total,
                                      orderStatusColor: value
                                          .approvedOrderList[index]
                                          .orderStatusColor,
                                      itemInfo: value
                                          .approvedOrderList[index].itemInfo,
                                    ),
                                  ))
                          : const SizedBox(),
                    ),
                    CustomOrdersTabBarView(
                      widget: value.deliveringOrderList.isNotEmpty
                          ? ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.deliveringOrderList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          RoutePaths.orderDetail,
                                          arguments: <String, dynamic>{
                                            'orderId': value
                                                .deliveringOrderList[index].id,
                                          });
                                    },
                                    child: CustomOrderItemWidget(
                                      itemCount: value
                                          .deliveringOrderList[index].itemCount,
                                      orderCode: value
                                          .deliveringOrderList[index].orderCode,
                                      orderStatus: value
                                          .deliveringOrderList[index]
                                          .orderStatus,
                                      paymentDate: value
                                          .deliveringOrderList[index]
                                          .paymentDate,
                                      total: value
                                          .deliveringOrderList[index].total,
                                      orderStatusColor: value
                                          .deliveringOrderList[index]
                                          .orderStatusColor,
                                      itemInfo: value
                                          .deliveringOrderList[index].itemInfo,
                                    ),
                                  ))
                          : const SizedBox(),
                    ),
                    CustomOrdersTabBarView(
                      widget: value.deliveredOrderList.isNotEmpty
                          ? ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.deliveredOrderList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          RoutePaths.orderDetail,
                                          arguments: <String, dynamic>{
                                            'orderId': value
                                                .deliveredOrderList[index].id,
                                          });
                                    },
                                    child: CustomOrderItemWidget(
                                      itemCount: value
                                          .deliveredOrderList[index].itemCount,
                                      orderCode: value
                                          .deliveredOrderList[index].orderCode,
                                      orderStatus: value
                                          .deliveredOrderList[index]
                                          .orderStatus,
                                      paymentDate: value
                                          .deliveredOrderList[index]
                                          .paymentDate,
                                      total:
                                          value.deliveredOrderList[index].total,
                                      orderStatusColor: value
                                          .deliveredOrderList[index]
                                          .orderStatusColor,
                                      itemInfo: value
                                          .deliveredOrderList[index].itemInfo,
                                    ),
                                  ))
                          : const SizedBox(),
                    ),
                  ],
                ),
                PSProgressIndicator(value.currentStatus)
              ]);
            }),
          ),
        ));
  }
}
