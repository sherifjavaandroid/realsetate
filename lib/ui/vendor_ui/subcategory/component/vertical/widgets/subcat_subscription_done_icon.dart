import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/common/subscribe_topic_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/subscribe_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/subscripe_topic_parameter_holder.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../common/dialog/success_dialog.dart';

class SubscriptionDoneIcon extends StatefulWidget {
  const SubscriptionDoneIcon(
      {required this.subCategoryProvider, required this.changeMode});
  final SubCategoryProvider subCategoryProvider;
  final Function changeMode;
  @override
  _SubCatSubscriptionDoneState createState() => _SubCatSubscriptionDoneState();
}

class _SubCatSubscriptionDoneState extends State<SubscriptionDoneIcon> {
  late PsValueHolder valueHolder;
  SubscribeTopicProvider? subscribeTopicProvider;
  Future<void> doSubscription() async {
    final List<String?> subscribeListWithMB = <String?>[];
    for (String? temp in widget.subCategoryProvider.subscribeList) {
      subscribeListWithMB.add(temp! + '_MB');
    }

    final SubscribeParameterHolder holder = SubscribeParameterHolder(
      userId: valueHolder.loginUserId!,
      catId: widget.subCategoryProvider.categoryId,
      selectedsubCatId: subscribeListWithMB,
    );

    await PsProgressDialog.showDialog(context);
    final PsResource<ApiStatus> subscribeStatus =
        await widget.subCategoryProvider.postData(
            requestBodyHolder: holder,
            requestPathHolder: RequestPathHolder(
                loginUserId: valueHolder.loginUserId,
                headerToken: valueHolder.headerToken));
   await PsProgressDialog.dismissDialog();

    if (subscribeStatus.status == PsStatus.SUCCESS) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext contet) {
            return SuccessDialog(
              message: 'Successful Subscription'.tr,
              onPressed: () {},
            );
          });

      //substract unscribed_topics from subscribed_topics (subscribe - unsubscribe)
      // Utils.subscribeToModelTopics(List<String>.from(
      //     Set<String>.from(subscribeListWithMB).difference(Set<String>.from(
      //         widget.subCategoryProvider.unsubscribeListWithMB))));
      if (Platform.isIOS) {
        FirebaseMessaging.instance.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true);
      }
      subscribeTopicProvider = SubscribeTopicProvider(context: context);
      final List<String?> subcatList = List<String>.from(
          Set<String>.from(subscribeListWithMB).difference(Set<String>.from(
              widget.subCategoryProvider.unsubscribeListWithMB)));
      for (String? subCat in subcatList) {
        subscribeTopicProvider?.postData(
            requestBodyHolder: SubscripeTopicParameterHolder(
                token: valueHolder.deviceToken, topic: subCat ?? ''),
            requestPathHolder: RequestPathHolder(
                languageCode: valueHolder.languageCode ?? 'en'));
      }

      Utils.unSubsribeFromModelTopics(
          widget.subCategoryProvider.unsubscribeListWithMB);

      widget.subCategoryProvider.subscribeList.clear();
      widget.subCategoryProvider.unsubscribeListWithMB.clear();
      widget.subCategoryProvider.loadDataList(
        reset: true,
      );
      widget.changeMode();
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext contet) {
            return ErrorDialog(
              message: 'subscribe failed.'.tr,
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: InkWell(
        onTap: () async {
          if (widget.subCategoryProvider.subscribeList.isNotEmpty) {
            doSubscription();
          } else {
            widget.subCategoryProvider.loadDataList(
              reset: true,
            );
            //do nothing and change mode
            widget.changeMode();
            widget.subCategoryProvider.loadDataList(
              reset: true,
            );
          }
        },
        child: Center(
          child: Text('new_psw_create_done'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).primaryColor)),
        ),
      ),
    );
  }
}
