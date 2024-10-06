import 'dart:async';

import '../api/common/ps_resource.dart';
import '../api/common/ps_status.dart';
import '../api/ps_api_service.dart';
import '../db/common/ps_data_source_manager.dart';
import '../db/theme_dao.dart';
import '../viewobject/common/ps_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/ps_repository.dart';

class ThemeRepository extends PsRepository {
  ThemeRepository({
    required PsApiService psApiService,
    required ThemeDao themeDao,
  }) {
    _psApiService = psApiService;
    _themeDao = themeDao;

  }

  late PsApiService _psApiService;
  late ThemeDao _themeDao;

  @override
  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForOne(
      dao: _themeDao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () => _psApiService
          .getAllThemeInfoForMobile(requestPathHolder?.languageCode ?? 'en'),
    );
  }

  Future<dynamic> loadThemeFromDB(
      StreamController<PsResource<dynamic>> streamController,
      PsStatus status) async {
    streamController.sink.add(await _themeDao.getOne(status: status));
  }
}
