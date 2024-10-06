

import '../common/ps_holder.dart';

class ResendCodeAgainParameterHolder
    extends PsHolder<ResendCodeAgainParameterHolder> {
  ResendCodeAgainParameterHolder({required this.userEmail});

  final String? userEmail;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['user_email'] = userEmail;

    return map;
  }

  @override
  ResendCodeAgainParameterHolder fromMap(dynamic dynamicData) {
    return ResendCodeAgainParameterHolder(
      userEmail: dynamicData['user_email'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userEmail != '') {
      key += userEmail!;
    }
    return key;
  }
}
