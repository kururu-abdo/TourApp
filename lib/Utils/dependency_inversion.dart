import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:tourapp/Bloc/location_bloc.dart';

import 'package:tourapp/Data/location_provider.dart';
import 'package:tourapp/DataSources/local_Data_sources.dart';
import 'package:tourapp/DataSources/remote_data_sources.dart';
import 'package:tourapp/Repository/location_repositroy.dart';
import 'package:tourapp/network/network_info.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
//Bloc
  sl.registerFactory(() => LocationBloc());

  ///modell

  ///  repositorieds [kururu secrets]
  sl.registerLazySingleton<RepositoryContract>(
      () => Repository(provider: sl()));

  sl.registerFactory(
      () => LocationProvider(remote: sl(), net: sl(), local: sl()));

  ///
// data sources

  sl.registerLazySingleton<RemoteContract>(
      () => Remote(loc: sl(), client: sl()));

  sl.registerLazySingleton<LocalContract>(() => Local());
  //sl.registerLazySingleton(() => Local);
// core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

// exterinal

  sl.registerLazySingleton(() => DataConnectionChecker());

  sl.registerLazySingleton<Client >(() => Client());
}
