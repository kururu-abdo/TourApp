import 'dart:convert';

import 'package:http/http.dart';
import 'package:tourapp/Models/location_models.dart';
import 'package:tourapp/Utils/constaints.dart';

abstract class RemoteContract{
getLocationByType(String type);
 Future<List<LocationModel>>  getAllLocations() ;

Future<List<LocationModel>> search(String str);
}
class Remote implements RemoteContract{
  Client client =new Client();
  @override
Future<List<LocationModel>>  getLocationByType(String type) async {
var response = await client.get("$GET_TYPE_URL/location?type=$type");

if(response.statusCode==200 ||  response.statusCode==201){
  Iterable l = json.decode(response.body);
List<LocationModel> locations = l.map(( model)=> LocationModel.fromJson(model)).toList();



  





return  locations;

}else{
  throw Exception("problem with server");
} 

  
  }




Future<List<LocationModel>>   getAllLocations() async {
var response = await client.get("$GET_ALL_URL/location");


if(response.statusCode==200 ||  response.statusCode==201){
 Iterable l = json.decode(response.body);
List<LocationModel> locations = l.map(( model)=> LocationModel.fromJson(model)).toList();




  





return  locations;

}else{
  throw Exception("problem with server");
} 

  
  }

  @override
  Future<List<LocationModel>> search(String str)  async{
var response = await client.get("https://0a3d17bd.ngrok.io/location?search=$str");
    


    
if(response.statusCode==200 ||  response.statusCode==201){
 Iterable l = json.decode(response.body);
List<LocationModel> locations = l.map(( model)=> LocationModel.fromJson(model)).toList();



  





return locations;

}else{
  throw Exception("problem with server");
} 

  }



  

}