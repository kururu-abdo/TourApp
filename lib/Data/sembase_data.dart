import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:tourapp/Models/location_models.dart';

class LocationDataBase{

  
String dbPath = 'locations.db';
DatabaseFactory dbFactory = databaseFactoryIo;

// We use the database factory to open the database

  

   insert(String type  ,ls ) async{
Database db = await dbFactory.openDatabase(dbPath);
var store= StoreRef.main();
store.record(type).put(db,ls);
  }


Future<List<LocationModel>>getType(type) async{
  Database db = await dbFactory.openDatabase(dbPath);
var store= StoreRef.main();
 var ls =await  store.record(type ).get(db)   ;

 return ls;

}

}