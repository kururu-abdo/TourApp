import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "AIzaSyBOelcDjGv8FAX0EziMlNQ9t5FSKNCl40I";
const MapQuestApiKey = "V4vl9A5kJ3cs5feSrdNg1tKIhfgvhBNQ";

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Future<String> getRoutePoints(LatLng l1, LatLng l2) async {
    String url =
        "https://api.mapbox.com/directions/v5/mapbox/driving/${l1.latitude}%2C${l1.longitude}%3B${l2.latitude}%2C${l2.longitude}.json?access_token=pk.eyJ1Ijoia3VydXJ1OTUiLCJhIjoiY2s1MHZpMDZzMGl2NzNscW4ydWw3cjcxNSJ9.A32cZY1fxzxsR_mqNv7I2w";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    var waypoints = values["routes"][0]["geometry"];
    // var points =
    //     waypoints.map((point) => WayPoints.fromJson(point)).toList().toString();
    return waypoints;
  }
}

class WayPoints {
  double lat;
  double lon;

  WayPoints.fromJson(Map<String, dynamic> jsonMap) {
    lat = jsonMap["location"][0];
    lon = jsonMap["location"][1];
  }
}
