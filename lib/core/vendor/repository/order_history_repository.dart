import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/order_history_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';

import 'Common/ps_repository.dart';

class OrderHistoryRepository extends PsRepository {
  OrderHistoryRepository({required PsApiService psApiService}) {
    _psApiService = psApiService;
    _orderDao = OrderDao.instance;
  }

  late PsApiService _psApiService;
  late OrderDao _orderDao;


  @override
  Future<void> loadDataList(
      {required StreamController<PsResource<dynamic>> streamController,
      PsHolder<dynamic>? requestBodyHolder,
      RequestPathHolder? requestPathHolder,
      required int limit,
      required int offset,
      required DataConfiguration dataConfig}) async {
    await startResourceSinkingForList(
      dao: _orderDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getOrderHistory(
        requestBodyHolder!.toMap(),
        requestPathHolder!.loginUserId!,
        0, 0,
       
        requestPathHolder.languageCode ?? 'en',
      ),
    );
  }

  @override
  Future<void> loadNextDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForNextList(
      dao: _orderDao,
      streamController: streamController,
      loadingStatus: PsStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService.getOrderHistory(
        requestBodyHolder!.toMap(),
        requestPathHolder!.loginUserId!,
        0,
        0,
        requestPathHolder.languageCode ?? 'en',
      ),
    );
  }

}
