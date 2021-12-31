import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SharedPrefModule {
  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
