import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/repository/Common/subscribe_topic_repository.dart';
import 'package:psxmpc/core/vendor/viewobject/api_status.dart';
import '../../api/common/ps_resource.dart';
import '../../api/ps_api_service.dart';
import '../../constant/ps_constants.dart';
import 'ps_provider.dart';

class SubscribeTopicProvider extends PsProvider<ApiStatus> {
  SubscribeTopicProvider({required BuildContext context,})
      : super(initRepo(context),0, subscriptionType: PsConst.NO_SUBSCRIPTION);

  static SubscribeTopicRepository initRepo(BuildContext context) {
    return SubscribeTopicRepository(
        psApiService: Provider.of<PsApiService>(context, listen: false));
  }

  PsResource<ApiStatus> get subScribeTopic => super.data;
  
  
 
}
