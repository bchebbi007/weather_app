import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'core/services/shared_preferences_service.dart';
import 'injection.config.dart';


final locator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies() async => $initGetIt(locator);

@module
abstract class GlobalModule {

  @preResolve
  Future<SharedPreferencesService> get sharedPreferencesInstance async =>
      await SharedPreferencesService.getInstance();
}
