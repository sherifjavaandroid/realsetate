import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class Chat extends PsObject<Chat?> {
  Chat({
    this.itemId,
    this.receiverId,
    this.senderId,
  });

  String? itemId;
  String? receiverId;
  String? senderId;

  @override
  bool operator ==(dynamic other) => other is Chat && itemId == other.itemId;

  @override
  int get hashCode => hash2(itemId.hashCode, itemId.hashCode);

  @override
  String? getPrimaryKey() {
    return itemId;
  }

  @override
  List<Chat?> fromMapList(List<dynamic> dynamicDataList) {
    final List<Chat?> subCategoryList = <Chat?>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subCategoryList.add(fromMap(dynamicData));
      }
    }
    // }
    return subCategoryList;
  }

  @override
  Chat? fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return Chat(
        itemId: dynamicData['itemId'],
        receiverId: dynamicData['receiverId'],
        senderId: dynamicData['senderId'],
      );
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Chat?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (Chat? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }
    return mapList;
  }

  @override
  Map<String, dynamic>? toMap(Chat? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['itemId'] = object.itemId;
      data['receiverId'] = object.receiverId;
      data['senderId'] = object.senderId;
      return data;
    } else {
      return null;
    }
  }
}
