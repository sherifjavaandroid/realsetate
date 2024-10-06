import '../common/ps_holder.dart';

class AddToCartParameterHolder extends PsHolder<AddToCartParameterHolder> {
  AddToCartParameterHolder({
    this.vendorId,
    this.itemId,
    this.quantity,
    this.userId,
    this.isSelect
  });

  String? vendorId;
  String? itemId;
  String? quantity;
  String? userId;
  String? isSelect;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['vendor_id'] = vendorId;
    map['item_id'] = itemId;
    map['quantity'] = quantity;
    map['user_id'] = userId;
    map['is_select'] = isSelect;

    return map;
  }

    @override
  AddToCartParameterHolder fromMap(dynamic dynamicData) {
    return AddToCartParameterHolder(
      vendorId: dynamicData['vendor_id'],
      itemId: dynamicData['item_id'],
      quantity: dynamicData['quantity'],
      userId: dynamicData['userId'],
      isSelect: dynamicData['is_select']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (vendorId != '') {
      key += vendorId! + ':';
    }
    if (itemId != '') {
      key += itemId ?? '';
    }
    if (quantity != '') {
      key += quantity ?? '';
    }
    if (userId != '') {
      key += userId ?? '';
    }
    return key;
  }
}
