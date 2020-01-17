import 'package:sembast/sembast.dart';
import 'package:tourapp/Models/location_models.dart';
import 'sembast_data_base.dart';

class LocationDao{
   static const  String locations ="location";
   
   final _locations =stringMapStoreFactory.store(locations);



Future<Database> get _db async => await AppDatabase.instance.database;

 

 Future insert(LocationModel  ls) async{

await _locations.add(await _db ,ls.toJson());
 }


Future <List<LocationModel>>  getAll() async {
final finder=Finder();

final recordSnapshot =  await  _locations.find(
await _db ,
finder: finder

);


return recordSnapshot.map( (snapshot){
final location =LocationModel.fromJson(snapshot.value);
//location.locationId =snapshot.key;
return location;
}).toList();

}



 Future <List<LocationModel>>  getType(String type) async {
final finder=Finder(
  filter: Filter.equals("type", type)
);

final recordSnapshot =  await  _locations.find(
await _db ,
finder: finder

);


return recordSnapshot.map( (snapshot){
final location =LocationModel.fromJson(snapshot.value);
//location.locationId =snapshot.key;
return location;
}).toList();

}



}