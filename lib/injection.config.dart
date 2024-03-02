// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app/weather/data/datasources/weather_datasource.dart' as _i3;
import 'app/weather/data/repository/weather_repository.dart' as _i14;
import 'app/weather/domain/usecases/get_five_day_data.dart' as _i4;
import 'app/weather/domain/usecases/get_weather_by_city.dart' as _i5;
import 'app/weather/presentation/controllers/weather_cubit.dart' as _i12;
import 'app/weather/presentation/controllers/weather_list_cubit.dart' as _i13;
import 'core/services/http_service.dart' as _i6;
import 'core/services/location_service.dart' as _i7;
import 'core/services/navigation_service.dart' as _i8;
import 'core/services/permission_handler_service.dart' as _i9;
import 'core/services/shared_preferences_service.dart' as _i10;
import 'core/services/snackbar_service.dart' as _i11;
import 'injection.dart' as _i15;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final globalModule = _$GlobalModule();
  gh.lazySingleton<_i3.BaseWeatherDatasource>(() => _i3.WeatherDatasource());
  gh.lazySingleton<_i4.GetFiveDayData>(() => _i4.GetFiveDayData());
  gh.lazySingleton<_i5.GetWeatherByCity>(() => _i5.GetWeatherByCity());
  gh.lazySingleton<_i6.HttpService>(() => _i6.HttpService());
  gh.lazySingleton<_i7.LocationService>(() => _i7.LocationService());
  gh.lazySingleton<_i8.NavigationService>(() => _i8.NavigationService());
  gh.lazySingleton<_i9.PermissonHandlerService>(
      () => _i9.PermissonHandlerService());
  await gh.factoryAsync<_i10.SharedPreferencesService>(
    () => globalModule.sharedPreferencesInstance,
    preResolve: true,
  );
  gh.lazySingleton<_i11.SnackbarService>(() => _i11.SnackbarService());
  gh.factory<_i12.WeatherCubit>(() => _i12.WeatherCubit());
  gh.factory<_i13.WeatherListCubit>(() => _i13.WeatherListCubit());
  gh.lazySingleton<_i14.WeatherRepository>(() => _i14.WeatherRepository());
  return getIt;
}

class _$GlobalModule extends _i15.GlobalModule {}
