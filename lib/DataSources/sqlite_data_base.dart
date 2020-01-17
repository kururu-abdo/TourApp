import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tourapp/Models/location_models.dart';

 
class DBHelper {
  static Database _db;
  static const location_id ="loation_id";
static const location_name ="loation_name";
static const state ="state";
static const type ="type";
static const pic ="pic";
static const description ="description";
static const lat ="lat";
static const lon ="lon";
static const String TABLE = 'Location';
  static const String DB_NAME = 'location.db';
 
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }
 
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
 
  _onCreate(Database db, int version) async {

try{
 await db
        .execute("CREATE TABLE $TABLE ($location_id INTEGER PRIMARY KEY ,$location_name TEXT   ,$state  TEXT  ,$type TEXT ,$pic TEXT ,$description TEXT ,$lat REAL ,$lon  REAL )"  );
  
} on  DatabaseException{
  throw Exception();
}
  
      
  }
 
 
 


 Future<List<LocationModel>>  getLocation(String  type) async {
    var dbClient = await db;
   // List<Map> maps = await db.query(DatabaseCreator.locationTable,where: "type=?" ,whereArgs: [type]);
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE  where  type ==$type");
    List<LocationModel> locations = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        locations.add(LocationModel.fromJson(maps[i]));
      }
    }
    return locations;
  }


 Future<List<LocationModel>>  getAlLocations() async {
    var dbClient = await db;
   // List<Map> maps = await db.query(DatabaseCreator.locationTable);
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<LocationModel> locations = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        locations.add(LocationModel.fromJson(maps[i]));
      }
    }
    return locations;
  }

 Future<LocationModel> save(LocationModel model) async {
    var dbClient = await db;
    // employee.id = await dbClient.insert(TABLE, employee.toMap());
    // return employee;
  
    await dbClient.transaction((txn) async {
      var query = """ INSERT INTO $TABLE ($location_id  ,$location_name ,$state , $type ,$pic ,$description ,
$lat ,$lon
      
      ) 
      VALUES (
        ${model.locationId} ,
          ${model.locationName} ,
            ${model.state} ,
              ${model.type} ,
                ${model.pic} ,
                  ${model.description} ,
                    ${model.lat} ,
                      ${model.longitude} 

      )   " """   ;
      return await txn.rawInsert(query);
    });
  
  }







  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}