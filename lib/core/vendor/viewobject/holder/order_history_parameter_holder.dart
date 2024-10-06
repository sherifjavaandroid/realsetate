import '../../constant/ps_constants.dart';
import '../common/ps_holder.dart';

class OrderHistoryParameterHolder extends PsHolder<dynamic> {
  OrderHistoryParameterHolder() {
    orderStatus = '0';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    page = '';
    noPagination = true;
  }

  String? orderBy;
  String? orderType;
  String? page;
  String? orderStatus;
  bool? noPagination;

  OrderHistoryParameterHolder getAllParameterHolder() {
    orderStatus = '0';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    page = '0';
    noPagination = true;

    return this;
  }

  OrderHistoryParameterHolder getOldestAllParameterHolder() {
    orderStatus = '0';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__ASC;
    page = '0';
    noPagination = true;

    return this;
  }

  OrderHistoryParameterHolder getPriceHightToLowAllParameterHolder() {
    orderStatus = '0';
    orderBy = PsConst.FILTERING__TOTAL_PRICE;
    orderType = PsConst.FILTERING__DESC;
    page = '0';
    noPagination = true;

    return this;
  }

  OrderHistoryParameterHolder getPriceLowToHighAllParameterHolder() {
    orderStatus = '0';
    orderBy = PsConst.FILTERING__TOTAL_PRICE;
    orderType = PsConst.FILTERING__ASC;
    page = '0';
    noPagination = true;

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['order_status'] = orderStatus;
    map['order_by'] = orderBy;
    map['order_type'] = orderType;
    map['page'] = page;
    map['noPagination'] = noPagination;

    return map;
  }

  @override
  dynamic fromMap(dynamic dynamicData) {
    orderStatus = dynamicData['order_status'];
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    page = dynamicData['page'];
    noPagination = dynamicData['noPagination'];

    return this;
  }

  @override
  String getParamKey() {
    String result = '';

    if (orderBy != '') {
      result += orderBy! + ':';
    }
    if (orderType != '') {
      result += orderType! + ':';
    }
    if (page != '') {
      result += page!;
    }

    return result;
  }
}
