import 'package:sembast/sembast.dart';

import '../viewobject/theme.dart';
import 'common/ps_dao.dart';


class ThemeDao extends PsDao<MobileTheme>{
  ThemeDao._() {
    init(MobileTheme());
  }

  static const String STORE_NAME = 'Theme';
  final String _primaryKey = '';
  // Singleton instance
  static final ThemeDao _singleton = ThemeDao._();

  // Singleton accessor
  static ThemeDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(MobileTheme object) {
    return '';
  }

  @override
  Filter getFilter(MobileTheme object) {
    return Filter.equals(_primaryKey, '');
  }
}
