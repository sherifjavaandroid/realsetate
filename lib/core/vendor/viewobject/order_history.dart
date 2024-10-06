import 'package:quiver/core.dart';

import 'common/ps_object.dart';
import 'item_info.dart';

class OrderHistory extends PsObject<OrderHistory> {
  OrderHistory(
      {this.id,
      this.itemCount,
      this.orderCode,
      this.orderStatus,
      this.paymentDate,
      this.paymentStatus,
      this.total,
      this.vendorName,
      this.paymentStatusColor,
      this.orderStatusColor,
      this.orderDate,
      this.itemInfo});

  String? id;
  String? orderCode;
  String? orderDate;
  String? paymentStatus;
  String? paymentStatusColor;
  String? orderStatus;
  String? paymentDate;
  String? vendorName;
  int? itemCount;
  String? total;
  String? orderStatusColor;
  List<ItemInfo>? itemInfo;

  @override
  bool operator ==(dynamic other) => other is OrderHistory && id == other.id;

  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  OrderHistory fromMap(dynamic dynamicData) {
    return OrderHistory(
      id: dynamicData['id'],
      orderCode: dynamicData['order_code'],
      paymentStatus: dynamicData['payment_status'],
      orderStatus: dynamicData['order_status'],
      paymentDate: dynamicData['payment_date'],
      vendorName: dynamicData['vendor_name'],
      itemCount: dynamicData['item_count'],
      orderDate: dynamicData['order_date'],
      total: dynamicData['total'],
      orderStatusColor: dynamicData['order_status_color'],
      paymentStatusColor: dynamicData['payment_status_color'],
      itemInfo: dynamicData['item_info'] != null
          ? ItemInfo().fromMapList(dynamicData['item_info'])
          : null,
    );
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['order_code'] = object.orderCode;
      data['payment_status'] = object.paymentStatus;
      data['order_status'] = object.orderStatus;
      data['payment_date'] = object.paymentDate;
      data['vendor_name'] = object.vendorName;
      data['item_count'] = object.itemCount;
      data['total'] = object.total;
      data['payment_status_color'] = object.paymentStatusColor;
      data['order_date'] = object.orderDate;
      data['order_status_color'] = object.orderStatusColor;
      data['item_info'] = ItemInfo().toMapList(object.itemInfo);

      return data;
    } else {
      return null;
    }
  }

  @override
  List<OrderHistory> fromMapList(List<dynamic> dynamicDataList) {
    final List<OrderHistory> orderList = <OrderHistory>[];

    for (dynamic json in dynamicDataList) {
      if (json != null) {
        orderList.add(fromMap(json));
      }
    }

    return orderList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<OrderHistory> objectList) {
    final List<Map<String, dynamic>?> dynamicList = <Map<String, dynamic>?>[];

    for (dynamic data in objectList) {
      if (data != null) {
        dynamicList.add(toMap(data));
      }
    }

    return dynamicList;
  }
}
