import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const apiKey = "AIzaSyBOelcDjGv8FAX0EziMlNQ9t5FSKNCl40I";
const MapQuestApiKey= "V4vl9A5kJ3cs5feSrdNg1tKIhfgvhBNQ";

class GoogleMapsServices{
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
Future <String> getRoutePoints(LatLng l1, LatLng l2)async{
String url  ="http://www.mapquestapi.com/directions/v2/route?key=${MapQuestApiKey}&from=${l1.latitude},${l1.longitude}&to=${l2.latitude},${l2.longitude}&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false";
   http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);

    return values["route"]["boundingBox"];


}




}