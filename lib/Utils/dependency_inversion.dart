
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'package:tourapp/Data/location_provider.dart';
import 'package:tourapp/DataSources/local_Data_sources.dart';
import 'package:tourapp/DataSources/remote_data_sources.dart';
import 'package:tourapp/Repository/location_repositroy.dart';
import 'package:tourapp/network/neteork_info.dart';
import 'package:http/http.dart' as http;
final sl =GetIt.instance;
Future<void> init()  async{
//Bloc 
sl.registerFactory( ( )=> LocationProvider(remote: sl() ,net: sl(),  local: sl()
 

) ) ;




///
///modell

///  repositorieds [kururu secrets]
sl.registerLazySingleton<RepositoryContract>(()=>
Repository()  );

// data sources 

sl.registerLazySingleton<LocalContract>(()=>  Local());

sl.registerLazySingleton<RemoteContract>(()=>  Remote());



// core 

sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImp(sl()));

// exterinal  





sl.registerLazySingleton(()=>DataConnectionChecker());

sl.registerLazySingleton(()=>http.Client);



}