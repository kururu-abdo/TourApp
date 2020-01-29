import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo{

  Future<bool> get  isConnected ;


}
class NetworkInfoImp implements NetworkInfo{
  DataConnectionChecker dataChecker ;
  NetworkInfoImp(this.dataChecker);

  @override
  Future<bool> get  isConnected=>dataChecker.hasConnection;
  
}