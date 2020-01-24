import 'package:hive/hive.dart';
import 'package:tourapp/Data/location_dao.dart';
import 'package:tourapp/DataSources/sqlite_data_base.dart';
import 'package:tourapp/Models/location_models.dart';

abstract class LocalContract{
 
cacheData(LocationModel data );
Future<List<LocationModel>> getLocationByType(String type);

Future<List<LocationModel>> getAllLocation();

Future<List<LocationModel>> search(String str );

}

class Local implements LocalContract{
  var myMap =Map<String  , Future<List<LocationModel>>>();
  var database =new DBHelper();
var dao =LocationDao();
  @override
Future<List<LocationModel>> getLocationByType(String type)  async{
  print("get from the local");

var sql = """SELECT * from ${DBHelper.TABLE} where ${DBHelper.type} ==$type """;
var data2 = await database.getLocation(type);
  // final data = await db.rawQuery(sql);
   List<LocationModel> locations =List<LocationModel>() ;
  //  for (final loc in data2) {
  //    final location =LocationModel.fromJson(loc);
  //    locations.add(location);
  //  }
locations=await database.getLocation(type);

   return locations;
  }

  

  @override
  cacheData(LocationModel data) async{

//myMap[type]=data;
//data.then((value) =>value.map((f)=>dao.insert(f)));
print("insideide local  data @@ ");
database.save(data);
dao.insert(data);




  }

  @override
  Future<List<LocationModel>> getAllLocation() async{
   var sql = """SELECT * from ${DBHelper.TABLE} """;

   final data = await database.getAlLocations();
   List<LocationModel> locations =List() ;
   locations= await database.getAlLocations();
   return locations;
  }

  @override
  Future<List<LocationModel>> search(String str)  async{
  List<LocationModel> locations =List<LocationModel>() ;
  //  for (final loc in data2) {
  //    final location =LocationModel.fromJson(loc);
  //    locations.add(location);
  //  }
locations=await database.search(str);

   return locations;
  }

  

}