import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/network_info.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreference = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreference);
  // app prefs instance
  //instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // todo dio factory

  //instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //todo
  //Dio dio = await instance<DioFactory>().getDio();

  // todo app service client
  //instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //todo
  // remote data source
  //instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // todo local data source
  //instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // todo
  // repository
  //instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance(), instance()));
}

/*initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}*/