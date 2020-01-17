import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'location_models.g.dart';
@HiveType()
class LocationModel {
  @HiveField(0)
  int _locationId;
   @HiveField(1)
  String _locationName;
   @HiveField(2)
  String _state;
   @HiveField(3)
  String _type;
  @HiveField(4)
String _pic;
 @HiveField(5)
String _description;
 @HiveField(6)
  double _lat;
 @HiveField(7)
  double  _longitude;

  LocationModel(
      {
        int locationId,
      String locationName,
      String state,
      String type,
     String pic,
     String description ,
      double lat,
      double  longitude}) {
    this._locationId = locationId;
    this._locationName = locationName;
    this._state = state;
    this._type = type;
   this._pic =pic;
   this._description=description;

    this._lat = lat;
    this._longitude = longitude;
  }

  int get locationId => _locationId;
  set locationId(int locationId) => _locationId = locationId;
  String get locationName => _locationName;
  set locationName(String locationName) => _locationName = locationName;
  String get state => _state;
  set state(String state) => _state = state;
  String get type => _type;
  set type(String type) => _type = type;
String get pic=>_pic;
set pic(String pic )=>_pic =pic;

String get description=>_description;
set desc(String description )=>_description =description;

  double get lat => _lat;
  set lat(double lat) => _lat = lat;
  double  get longitude => _longitude;
  set longitude(double longitude) => _longitude = longitude;

  LocationModel.fromJson(Map<String, dynamic> json) {
    _locationId = json['location_id'];
    _locationName = json['location_name'];
    _state = json['state'];
    _type = json['type'];
    _pic= json['pic'];
    _description=json['description'];
    _lat = json['lat'];
    _longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this._locationId;
    data['location_name'] = this._locationName;
    data['state'] = this._state;
    data['type'] = this._type;
  data['pic'] =this._pic;
    data['description'] =this._description;
    data['lat'] = this._lat;
    data['longitude'] = this._longitude;
    return data;
  }


  
}
// class LocationList{
// List<LocationModel>  locations;
// LocationList(
// { this.locations}
// );

// factory LocationList.fromJson(List<dynamic> parsedJson) {

//     List<LocationModel> locations = new List<LocationModel>();
// locations = parsedJson.map((i)=>LocationModel.fromJson(i)).toList();

//     return  LocationList(
//      locations : locations
//     );



//   }

// List<dynamic > toMap(){
//   List<dynamic> data =List<dynamic>();
// data =this.locations;  
// }
//}