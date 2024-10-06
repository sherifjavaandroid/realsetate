import '../common/ps_holder.dart';

class SubscripeTopicParameterHolder
    extends PsHolder<SubscripeTopicParameterHolder> {
  SubscripeTopicParameterHolder({
    required this.token,
    required this.topic,
  });

  final String? token;
  final String? topic;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['token'] = token;
    map['topic'] = topic;
    return map;
  }

  @override
  SubscripeTopicParameterHolder fromMap(dynamic dynamicData) {
    return SubscripeTopicParameterHolder(
      token: dynamicData['token'],
      topic: dynamicData['topic'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (token != '') {
      key += token!;
    }
    if (topic != '') {
      key += topic ?? '';
    }

    return key;
  }
}
