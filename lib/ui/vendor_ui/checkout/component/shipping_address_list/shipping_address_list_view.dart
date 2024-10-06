import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/all_shipping_address/all_shipping_address_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/order_id/order_id_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/checkout/component/shipping_address_list/widgets/shipping_address_box.dart';
import '../../../common/ps_button_widget_with_round_corner.dart';
import '../../../common/ps_ui_widget.dart';

class ShippingAddressListView extends StatefulWidget {
  const ShippingAddressListView({
    Key? key,
  }) : super(key: key);

  @override
  State<ShippingAddressListView> createState() =>
      _ShippingAddressListViewState();
}

class _ShippingAddressListViewState extends State<ShippingAddressListView> {
  PsValueHolder? valueHolder;

  late AppLocalization langProvider;

  AllShippingAddressProvider? allShippingAddressProvider;
  OrderIdProvider? orderIdProvider;
  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    orderIdProvider = Provider.of<OrderIdProvider>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          Navigator.pop(context, '2');
        }
      },
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
            ),
            title: Text('shipping_address'.tr,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic900
                        : PsColors.achromatic50,
                    fontWeight: FontWeight.w500,
                    fontSize: PsDimens.space18)),
          ),
          body: MultiProvider(
            providers: <SingleChildWidget>[
              ChangeNotifierProvider<AllShippingAddressProvider?>(
                  lazy: false,
                  create: (BuildContext context) {
                    allShippingAddressProvider =
                        AllShippingAddressProvider(context: context);
                    allShippingAddressProvider?.loadDataList(
                        requestPathHolder: RequestPathHolder(
                      loginUserId: Utils.checkUserLoginId(valueHolder),
                      languageCode: langProvider.currentLocale.languageCode,
                    ));
                    return allShippingAddressProvider;
                  }),
            ],
            child: Consumer<AllShippingAddressProvider>(builder:
                (BuildContext context, AllShippingAddressProvider value,
                    Widget? child) {
              return Stack(children: <Widget>[
                if (value.hasData)
                  ListView.builder(
                      padding: const EdgeInsets.only(bottom: PsDimens.space80),
                      itemCount: value.allShippingAddress.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomShippingAddressBox(
                          shippingDefault: value.allShippingAddress.data?[index]
                                  .isSaveShippingInfoForNextTime ==
                              '1',
                          billingDefault: value.allShippingAddress.data?[index]
                                  .isSaveBillingInfoForNextTime ==
                              '1',
                          onPressed: () async {
                            final dynamic result = await Navigator.of(context)
                                .pushNamed(RoutePaths.editShippingAddress,
                                    arguments: value.allShippingAddress
                                        .data?[index]) as String?;

                            if (result == '0') {
                              await allShippingAddressProvider?.loadDataList(
                                  requestPathHolder: RequestPathHolder(
                                loginUserId:
                                    Utils.checkUserLoginId(valueHolder),
                                languageCode:
                                    langProvider.currentLocale.languageCode,
                              ));
                            }
                          },
                          groupValue: int.tryParse(orderIdProvider
                                  ?.chooseShippingAddress?.id
                                  .toString() ??
                              '${value.allShippingAddress.data?[0].id}'),
                          shippingAddressList:
                              value.allShippingAddress.data?[index],
                          values: int.parse(allShippingAddressProvider
                                  ?.allShippingAddress.data?[index].id
                                  .toString() ??
                              ''),
                          onChanged: (int? p) {
                            value.values = p;
                            orderIdProvider?.chooseShippingAddress =
                                allShippingAddressProvider
                                    ?.allShippingAddress.data?[index];
                          },
                        );
                      }),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: PsDimens.space16, vertical: 5),
                      alignment: Alignment.bottomCenter,
                      child: Column(children: <Widget>[
                        PSButtonWidgetRoundCorner(
                          onPressed: () async {
                            final dynamic result =
                                await Navigator.of(context).pushNamed(
                              RoutePaths.shippingAddress,
                            ) as String?;

                            if (result == '1') {
                              await allShippingAddressProvider?.loadDataList(
                                  requestPathHolder: RequestPathHolder(
                                loginUserId:
                                    Utils.checkUserLoginId(valueHolder),
                                languageCode:
                                    langProvider.currentLocale.languageCode,
                              ));
                            }
                          },
                          titleTextColor: PsColors.achromatic50,
                          titleText: 'user_add_new_address'.tr,
                        ),
                        PSProgressIndicator(value.currentStatus),
                      ])),
                ),
              ]);
            }),
          )),
    );
  }
}
