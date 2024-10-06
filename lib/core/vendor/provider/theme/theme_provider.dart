import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/theme_repository.dart';
import '../../viewobject/theme.dart';
import '../common/ps_provider.dart';

class ThemeProvider extends PsProvider<MobileTheme> {
  ThemeProvider({
    required ThemeRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION)
   {
    _repo = repo;
  }
  ThemeRepository? _repo;

  PsResource<MobileTheme> get getTheme => super.data;

  Future<dynamic> loadThemeFromDB() async {
    isLoading = true;

    await _repo!.loadThemeFromDB(
        super.dataStreamController!, PsStatus.PROGRESS_LOADING);
  }
}
