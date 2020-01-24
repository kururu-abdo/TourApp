import 'dart:async';
import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourapp/Bloc/location_event.dart';
import 'package:tourapp/Bloc/location_state.dart';
import 'package:tourapp/Models/location_models.dart';
import 'package:tourapp/Repository/location_repositroy.dart';

class LocationBloc {
  final repo = GetIt.instance<RepositoryContract>();
  final _fetcher = PublishSubject<List<LocationModel>>();
  final _fetcher2 = PublishSubject<List<LocationModel>>();

  Observable<List<LocationModel>> get locationType => _fetcher.stream;
  Observable<List<LocationModel>> get allLocations => _fetcher2.stream;

fetchAllLocations(String type) async {
    var model = await repo.getAllLocations();
_fetcher2.sink.add(model);
  }
Future<List<LocationModel>> fetchSpecificType(String type ) async{
    List<LocationModel> model = await repo.getLocationType(type);
return model;
  }
Future<List<LocationModel>> search(String str ) async{
    List<LocationModel> model = await repo.search(str);
return model;
  }

  fetchLocationsByType(String type) async {
    List<LocationModel>   model = await repo.getLocationType(type);
    _fetcher.sink.add(model);
  }
  Future<double>  getDestince(double lat  ,double lon) async{
      // final  distance =  Distance();
var geolocator = Geolocator();
var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
double latitude ;
double longitude;
StreamSubscription<Position> positionStream = geolocator.getPositionStream(locationOptions).listen(
    (Position position) {
      latitude = position==null?0.0 : position.latitude;
   
        longitude = position==null?0.0 : position.longitude;

    });
   
Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

final double far = await Geolocator().distanceBetween(
lat,lon, position.latitude, position.longitude );
      // var km = distance.as(LengthUnit.Kilometer,
      // LatLng(lat,lon),await getCurrentLocation() );
      
print((far /1000).toString() + "km");

 return   (far /1000).toDouble() ;

}


Future<Position> getMyLocation() async{
Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

return position;



}
  dispose() {
    _fetcher.close();
    _fetcher2.close();
  }

  @override
  // TODO: implement initialState
  LocationState get initialState => InitialState();

  //@override
 //Stream<LocationState> mapEventToState(LocationEvent event) async*{
//     // TODO: implement mapEventToState
//      switch (LocationEvent ) {
//     case InitialState:
//       yield ShowMesums();
//       break;
//     case ShowMesums:
//       yield ShowPyramids();
//       break;
//        case ShowMesums:
//       yield ShowPyramids();
//       break;
//     default:
//       yield ShowPyramids();
//       break;
//   };
//   }
}
