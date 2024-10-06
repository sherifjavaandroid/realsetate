

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ChoosePaymentVIew extends StatefulWidget {
//   const ChoosePaymentVIew(
//       {Key? key, required this.product, required this.appInfo})
//       : super(key: key);

//   final Product? product;
//   final PSAppInfo appInfo;

//   @override
//   State<StatefulWidget> createState() {
//     return ChoosePaymentVIewState();
//   }
// }

// class ChoosePaymentVIewState extends State<ChoosePaymentVIew> {
//   UserRepository? repo1;
//   PsValueHolder? psValueHolder;
//   bool bindDataFirstTime = true;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     repo1 = Provider.of<UserRepository>(context);
//     psValueHolder = Provider.of<PsValueHolder>(context);

//     return ChangeNotifierProvider<UserProvider>(
//       lazy: false,
//       create: (BuildContext context) {
//         final UserProvider provider =
//             UserProvider(repo: repo1, psValueHolder: psValueHolder);
//         provider.getUser(provider.psValueHolder!.loginUserId);
//         return provider;
//       },
//       child: Consumer<UserProvider>(
//           builder: (BuildContext context, UserProvider provider, Widget? child) {
//         return Scaffold(
//           appBar: PsAppbarWidget(appBarTitle: 'pesapal_payment__title'.tr,),
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const SizedBox(height: PsDimens.space16),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     top: PsDimens.space28, left: PsDimens.space8),
//                 child: Text(
//                   'item_promote__choose_payment'.tr,
//                   textAlign: TextAlign.start,
//                   style: Theme.of(context)
//                       .textTheme
//                       .subtitle1!
//                       .copyWith(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: PsDimens.space16),
//               Container(
//                   margin: const EdgeInsets.only(
//                       top: PsDimens.space28,
//                       left: PsDimens.space12,
//                       right: PsDimens.space12),
//                   child: PSButtonWidget(
//                     hasShadow: true,
//                     width: double.infinity,
//                     titleText: 'item_promote__in_app_purchase'.tr,
//                     onPressed: () async {
//                       // InAppPurchase View
//                       final dynamic returnData = await Navigator.pushNamed(
//                           context, RoutePaths.inAppPurchase, arguments: <String, dynamic>{
//                         'productId': widget.product!.id,
//                         'appInfo': widget.appInfo
//                       });
//                       if (returnData == true) {
//                         Navigator.pop(context, true);
//                       }
//                     },
//                   )),
//               const SizedBox(height: PsDimens.space16),
//               Container(
//                   margin: const EdgeInsets.only(
//                       top: PsDimens.space16,
//                       left: PsDimens.space12,
//                       right: PsDimens.space12),
//                   child: PSButtonWidget(
//                     hasShadow: true,
//                     width: double.infinity,
//                     titleText:
//                         'item_promote__other'.tr,
//                     onPressed: () async {
//                       final dynamic returnData = await Navigator.pushNamed(
//                           context, RoutePaths.itemPromote,
//                           arguments: widget.product);
//                       if (returnData == true) {
//                         Navigator.pop(context, true);
//                       }
//                     },
//                   )),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

// dynamic callWarningDialog(BuildContext context, String text) {
//   showDialog<dynamic>(
//       context: context,
//       builder: (BuildContext context) {
//         return WarningDialog(
//           message: text.tr,
//           onPressed: () {},
//         );
//       });
// }
