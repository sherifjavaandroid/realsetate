import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/item_paid_history_parameter_holder.dart';
import '../../../../../config/ps_colors.dart';
import '../../../../../config/ps_config.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/item_paid_history.dart';
import '../../../../../core/vendor/viewobject/product.dart';
import '../../../common/base/ps_widget_with_appbar_with_no_provider.dart';
import '../../../common/dialog/error_dialog.dart';
import '../../../common/dialog/success_dialog.dart';
import '../../../common/dialog/warning_dialog_view.dart';
import '../../../common/ps_button_widget.dart';

class PayStackView extends StatefulWidget {
  const PayStackView(
      {Key? key,
      required this.product,
      required this.amount,
      required this.howManyDay,
      required this.paymentMethod,
      required this.stripePublishableKey,
      required this.startDate,
      required this.startTimeStamp,
      required this.itemPaidHistoryProvider,
      required this.userProvider,
      required this.payStackKey})
      : super(key: key);

  final Product product;
  final String? amount;
  final String? howManyDay;
  final String paymentMethod;
  final String? stripePublishableKey;
  final String? startDate;
  final String startTimeStamp;
  final ItemPromotionProvider itemPaidHistoryProvider;
  final UserProvider userProvider;
  final String? payStackKey;

  @override
  State<StatefulWidget> createState() {
    return PayStackViewState();
  }
}

class PayStackViewState extends State<PayStackView> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final PaystackPlugin plugin = PaystackPlugin();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    plugin.initialize(publicKey: widget.payStackKey ?? '');
    super.initState();
  }

  void setError(dynamic error) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: error.toString().tr,
          );
        });
  }

  dynamic callWarningDialog(BuildContext context, String text) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            message: text.tr,
            onPressed: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PsWidgetWithAppBarWithNoProvider(
      appBarTitle: 'item_promote__pay_stack'.tr,
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                CreditCardWidget(
                  frontCardBorder: Border.all(color: Colors.grey),
                  backCardBorder: Border.all(color: Colors.grey),
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: Utils.isLightMode(context)
                      ? Theme.of(context).primaryColor
                      : PsColors.achromatic800,
                  isSwipeGestureEnabled: true,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  height: 175,
                  width: MediaQuery.of(context).size.width,
                  animationDuration: PsConfig.animation_duration,
                  onCreditCardWidgetChange: (dynamic data) {},
                ),
                CreditCardForm(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formKey: formKey,
                  obscureCvv: true,
                  obscureNumber: true,
                  cardNumber: cardNumber,
                  cvvCode: cvvCode,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  cardHolderName: cardHolderName,
                  expiryDate: expiryDate,
                  inputConfiguration: const InputConfiguration(
                    cardNumberDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Card Holder',
                    ),
                  ),
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: PsDimens.space40,
                      left: PsDimens.space12,
                      right: PsDimens.space12),
                  child: PSButtonWidget(
                    hasShadow: true,
                    width: double.infinity,
                    titleText: 'credit_card__pay'.tr,
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        final FocusScopeNode currentFocus =
                            FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus)
                          currentFocus.focusedChild?.unfocus();

                        final Charge charge = Charge()
                          ..amount = (double.parse(Utils.getPriceTwoDecimal(
                                      widget.amount!)) *
                                  100)
                              .round()
                          ..email = widget.userProvider.user.data!.userEmail
                          ..reference = _getReference()
                          ..card = callCard(
                              cardNumber, expiryDate, cardHolderName, cvvCode);
                        try {
                          final CheckoutResponse response =
                              await plugin.checkout(
                            context,
                            method: CheckoutMethod.card,
                            charge: charge,
                            fullscreen: false,
                            // logo: MyLogo(),
                          );

                          if (response.status) {
                            payStackNow(response.reference!);
                          }
                        } catch (e) {
                          print('Check console for error');
                          rethrow;
                        }
                      }
                    },
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  dynamic payStackNow(String token) async {
    await PsProgressDialog.showDialog(context);
    callPaidAdSubmitApi(
      context,
      widget.product,
      widget.amount,
      widget.howManyDay,
      widget.paymentMethod,
      widget.stripePublishableKey,
      widget.startDate,
      widget.startTimeStamp,
      widget.itemPaidHistoryProvider,
      token,
    );
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  PaymentCard callCard(
    String cardNumber,
    String expiryDate,
    String cardHolderName,
    String cvvCode,
  ) {
    final List<String> monthAndYear = expiryDate.split('/');
    return PaymentCard(
        number: cardNumber,
        expiryMonth: int.parse(monthAndYear[0]),
        expiryYear: int.parse(monthAndYear[1]),
        name: cardHolderName,
        cvc: cvvCode);
  }

  dynamic callPaidAdSubmitApi(
    BuildContext context,
    Product product,
    String? amount,
    String? howManyDay,
    String paymentMethod,
    String? stripePublishableKey,
    String? startDate,
    String startTimeStamp,
    ItemPromotionProvider itemPaidHistoryProvider,
    // ProgressDialog progressDialog,
    String? token,
  ) async {
    if (await Utils.checkInternetConnectivity()) {
      final ItemPaidHistoryParameterHolder itemPaidHistoryParameterHolder =
          ItemPaidHistoryParameterHolder(
              itemId: product.id,
              amount: amount,
              howManyDay: howManyDay,
              paymentMethod: paymentMethod,
              paymentMethodNounce: Platform.isIOS ? token : token,
              startDate: startDate,
              startTimeStamp: startTimeStamp,
              razorId: '',
              purchasedId: '',
              isPaystack: PsConst.ONE,
              inAppPurchasedProductId: '');
      final PsValueHolder psValueHolder =
          Provider.of<PsValueHolder>(context, listen: false);
      final PsResource<ItemPaidHistory> padiHistoryDataStatus =
          await itemPaidHistoryProvider.postData(
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder)),
              requestBodyHolder: itemPaidHistoryParameterHolder);

      if (padiHistoryDataStatus.data != null) {
        // progressDialog.dismiss();
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext contet) {
              return SuccessDialog(
                message: 'item_promote__success'.tr,
                onPressed: () {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                },
              );
            });
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: padiHistoryDataStatus.message,
              );
            });
      }
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'error_dialog__no_internet'.tr,
            );
          });
    }
  }
}
