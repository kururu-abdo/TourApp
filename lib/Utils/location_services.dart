import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
class LocationUtils{




var distance;



// static  Future<LatLng>   getCurrentLocation() async{

//    var current_location = Location();

// var loc;
//  var myloc=current_location.onLocationChanged().listen((LocationData currentLocation) {

//   loc=LatLng(currentLocation.latitude, currentLocation.longitude);
// });
// return loc;

// }

static  Future<String>  getDestince(double lat  ,double lon) async{
      final  distance =  Distance();

Position position = await Geolocator().getLastKnownPosition();

final double far = await Geolocator().distanceBetween(
14.3448544,36.6013895,position.longitude ,position.latitude);
      // var km = distance.as(LengthUnit.Kilometer,
      // LatLng(lat,lon),await getCurrentLocation() );
      
      // return km;
return  far.toString();
}


}