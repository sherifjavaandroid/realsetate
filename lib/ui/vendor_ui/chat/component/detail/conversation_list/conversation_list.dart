import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/chat/chat_history_list_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../custom_ui/chat/component/detail/conversation_list/widgets/conversation_list_item.dart';
import '../../../../../custom_ui/chat/component/detail/conversation_list/widgets/date_widget.dart';

class ConversationList extends StatelessWidget {
  const ConversationList(
      {required this.messagesRef,
      required this.sessionId,
      required this.isUserOnline,
      required this.updateDataToFireBase,
      required this.insertDataToFireBase,
      required this.deleteDataToFireBase,
      required this.otherUserId});

  final DatabaseReference messagesRef;
  final String? sessionId;
  final String isUserOnline;
  final Function updateDataToFireBase;
  final Function insertDataToFireBase;
  final Function deleteDataToFireBase;
  final String? otherUserId;
  @override
  Widget build(BuildContext context) {
    String? lastTimeStamp;
    int? lastAddedDateTimeStamp;
    const bool _anchorToBottom = true;
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final Product itemDetail = itemDetailProvider.product;
    final ChatHistoryListProvider chatHistoryListProvider =
        Provider.of<ChatHistoryListProvider>(context);
    int _totalCount = 0;

    Future<void> _getTotalChildrenCount(String itemid) async {
      final DatabaseEvent event = await messagesRef
          .child(sessionId!)
          .orderByChild('itemId')
          .equalTo(itemid)
          .once();

      final DataSnapshot snapshot = event.snapshot;
      final Map<dynamic, dynamic>? data =
          snapshot.value as Map<dynamic, dynamic>?;

      _totalCount = data != null ? data.length : 0;
      _totalCount--;

      chatHistoryListProvider.setTotalCount(_totalCount);
    }

    // ignore: always_specify_types
    Future.delayed(const Duration(milliseconds: 2000)).then((_) {
      _getTotalChildrenCount(itemDetail.id!);
    });

    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(top: PsDimens.space16),
        child: FirebaseAnimatedList(
          key: const ValueKey<bool>(_anchorToBottom),
          query: messagesRef
              .child(sessionId!)
              .orderByChild('itemId')
              .equalTo(itemDetail.id),
          reverse: _anchorToBottom,
          sort: (DataSnapshot a, DataSnapshot b) {
            return Message()
                .fromMap(b.value)!
                .addedDateTimeStamp // ['addedDate']
                .toString()
                .compareTo(
                    Message().fromMap(a.value)!.addedDateTimeStamp.toString());
          },
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            print('- - - - - - -  /nIndex : $index');

            bool isSameDate = false;
            final Message messages = Message().fromMap(snapshot.value)!;
            final String chatDateString =
                Utils.convertTimeStampToDate(messages.addedDateTimeStamp);
            if (index == 0 || lastTimeStamp == null) {
              lastTimeStamp = chatDateString;
              lastAddedDateTimeStamp = messages.addedDateTimeStamp;
            }
            final DateTime msgDate =
                Utils.getDateOnlyFromTimeStamp(messages.addedDateTimeStamp!);
            final DateTime lastDate =
                Utils.getDateOnlyFromTimeStamp(lastAddedDateTimeStamp!);

            if (lastTimeStamp == chatDateString ||
                msgDate.compareTo(lastDate) >= 0) {
              isSameDate = true;
            } else {
              isSameDate = false;
            }

            // print(isSameDate);
            final Widget conversationListItem = CustomConversationListItem(
              messageObj: messages,
              updateDataToFireBase: updateDataToFireBase,
              insertDataToFireBase: insertDataToFireBase,
              deleteDataToFireBase: deleteDataToFireBase,
              index: index,
              isUserOnline: isUserOnline,
              otherUserId: otherUserId,
            );

            Widget _dateWidget = const SizedBox();
            if (!isSameDate) {
              _dateWidget =
                  CustomDateWidget(lastTimeStamp: lastTimeStamp ?? '');

              lastTimeStamp = chatDateString;
              lastAddedDateTimeStamp = messages.addedDateTimeStamp;
            }

            if (msgDate.compareTo(lastDate) >= 0) {
              lastTimeStamp = chatDateString;
              lastAddedDateTimeStamp = messages.addedDateTimeStamp;
            }

            return Selector<ChatHistoryListProvider, int>(
                selector:
                    (BuildContext context, ChatHistoryListProvider provider) =>
                        provider.totalCount,
                builder: (BuildContext context, int totalCount, Widget? child) {
                  final bool isLastIndex = index == totalCount;

                  return isSameDate
                      ? Column(
                          children: <Widget>[
                            if (isLastIndex) ...<Widget>[
                              CustomDateWidget(
                                  lastTimeStamp: lastTimeStamp ?? '')
                            ],
                            conversationListItem,
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (isLastIndex) ...<Widget>[
                              CustomDateWidget(
                                  lastTimeStamp: lastTimeStamp ?? '')
                            ],
                            conversationListItem,
                            _dateWidget,
                          ],
                        );
                });
          },
        ),
      ),
    );
  }
}
