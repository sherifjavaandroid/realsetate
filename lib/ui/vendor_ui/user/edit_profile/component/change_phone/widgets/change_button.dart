import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/verify_phone_internt_holder.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/ps_button_widget.dart';

class ChangeButton extends StatefulWidget {
  const ChangeButton(
      {required this.phoneController, required this.countryCodeController});
  final TextEditingController phoneController;
  final TextEditingController countryCodeController;

  @override
  __SendButtonWidgetState createState() => __SendButtonWidgetState();
}

class __SendButtonWidgetState extends State<ChangeButton> {
  Future<String?> verifyPhone() async {
    String? verificationId;
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) async{
      verificationId = verId;
     await PsProgressDialog.dismissDialog();
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int? forceCodeResend]) async {
      verificationId = verId;
     await PsProgressDialog.dismissDialog();
      print('code has been send');

      final dynamic returnEditPhone = await Navigator.pushNamed(
          context, RoutePaths.edit_phone_verify_container,
          arguments: VerifyPhoneIntentHolder(
              userName: '',
              phoneNumber: widget.countryCodeController.text +
                  '-' +
                  widget.phoneController.text,
              phoneId: verificationId));
      if (returnEditPhone != null && returnEditPhone is String) {
        Navigator.pop(context, returnEditPhone);
      }
    };
    final PhoneVerificationCompleted verifySuccess = (AuthCredential user)async {
      print('verify');
     await PsProgressDialog.dismissDialog();
    };
    final PhoneVerificationFailed verifyFail =
        (FirebaseAuthException exception) async{
      print('${exception.message}');
     await PsProgressDialog.dismissDialog();
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: '${exception.message}',
            );
          });
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:
            widget.countryCodeController.text + widget.phoneController.text,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(minutes: 2),
        verificationCompleted: verifySuccess,
        verificationFailed: verifyFail);
    return verificationId;
  }

  @override
  Widget build(BuildContext context) {
    return PSButtonWidget(
        colorData: Theme.of(context).primaryColor,
        hasShadow: true,
        width: double.infinity,
        titleText: 'edit_phone_btn'.tr,
        onPressed: () async {
          await PsProgressDialog.showDialog(context);
          await verifyPhone();
        });
  }
}
