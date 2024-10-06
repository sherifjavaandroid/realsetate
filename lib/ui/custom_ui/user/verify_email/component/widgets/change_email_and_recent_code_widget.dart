import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/verify_email/component/widgets/change_email_and_recent_code_widget.dart';

class CustomChangeEmailAndRecentCodeWidget extends StatelessWidget {
  const CustomChangeEmailAndRecentCodeWidget(
      {Key? key, this.isneedForgotPassword})
      : super(key: key);

  final bool? isneedForgotPassword;

  @override
  Widget build(BuildContext context) {
    return ChangeEmailAndRecentCodeWidget(
      isneedForgotPassword: isneedForgotPassword,
    );
  }
}
