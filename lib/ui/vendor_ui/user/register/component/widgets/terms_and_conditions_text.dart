import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class TermsAndConditionTextWidget extends StatefulWidget {
  const TermsAndConditionTextWidget({
    Key? key,
    required this.nameTextEditingController,
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
  }) : super(key: key);

  final TextEditingController? nameTextEditingController,
      emailTextEditingController,
      passwordTextEditingController;

  @override
  State<TermsAndConditionTextWidget> createState() =>
      _TermsAndConditionTextWidgetState();
}

class _TermsAndConditionTextWidgetState
    extends State<TermsAndConditionTextWidget> {
  late UserProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    return Container(
        padding: const EdgeInsets.only(bottom: PsDimens.space4),
        margin: const EdgeInsets.symmetric(
          vertical: PsDimens.space24,
          horizontal: PsDimens.space28,
        ),
        child: Column(
          children: <Widget>[
            Text('login_agree_text'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.text700
                        : PsColors.text50)),
            const SizedBox(
              height: 4,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  updateCheckBox(
                      context,
                      widget.nameTextEditingController,
                      widget.emailTextEditingController,
                      widget.passwordTextEditingController);
                });
              },
              child: Text('login__agree_privacy'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ));
  }

  void updateCheckBox(
      BuildContext context,
      TextEditingController? nameTextEditingController,
      TextEditingController? emailTextEditingController,
      TextEditingController? passwordTextEditingController) {
    provider.psValueHolder!.userNameToVerify = nameTextEditingController!.text;
    provider.psValueHolder!.userEmailToVerify =
        emailTextEditingController!.text;
    provider.psValueHolder!.userPasswordToVerify =
        passwordTextEditingController!.text;
    Navigator.pushNamed(context, RoutePaths.privacyPolicy);
  }
}
