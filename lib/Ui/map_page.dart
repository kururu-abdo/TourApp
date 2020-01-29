import 'dart:async';
import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tourapp/Utils/app_localizations.dart';
import 'package:tourapp/Utils/map_services.dart';

class mapPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String location;
  mapPage(this.latitude, this.longitude, this.location);

  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<mapPage> {
  double lat, lon;

  static const LatLng _center = const LatLng(33.738045, 73.084488);

  final Set<Polyline> _polyLines = {};
  Set<Polyline> get polyLines => _polyLines;

  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;
  LatLng _lastMapPosition = _center;
  List<LatLng> latlng = List();

  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  bool loading = true;
  Completer<GoogleMapController> ctr = Completer();
  static LatLng latLng;
  LocationData currentLocation;

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        visible: true,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.blue));
  }

  @override
  void initState() {
    getLocation();
    loading = true;
    super.initState();
    lat = widget.latitude;
    lon = widget.longitude;
    // latlng.add(_new);
    // latlng.add(_news);
  }

  @override
  void dispose() {
    super.dispose();
  }

  getLocation() async {
    var location = new Location();
    location.onLocationChanged().listen((currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      setState(() {
        latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
        // var target =
        //     LatLng(currentLocation.latitude, currentLocation.longitude);
        // var dest = LatLng(lat, lon);
        // latlng.add(dest);
        // latlng.add(target);
      });
      print("getLocation:$latLng");
      _onAddMarkerButtonPressed();
      loading = false;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("111"),
        position: latLng,
        infoWindow: InfoWindow(
          title: 'Your Location',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      // _polyLines.add(Polyline(
      //   polylineId: PolylineId(LatLng(lat, lon).toString()),
      //   visible: true,
      //   //latlng is List<LatLng>
      //   points: latlng,
      //   color: Colors.blue,
      // ));
    });
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void onCameraMove(CameraPosition position) {
    latLng = position.target;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    print(lList.toString());
    return lList;
  }

  void sendRequest() async {
    LatLng destination = LatLng(lat, lon);
    try {
      String route =
          await _googleMapsServices.getRoutePoints(latLng, destination);
      createRoute(route);
      _addMarker(destination, "KTHM Collage");
    } on Exception {
      Flushbar(
        backgroundGradient: LinearGradient(
          colors: [Colors.tealAccent],
        ),
        title: AppLocalizations.of(context).translate("internet_problem"),
        messageText:
            Text(AppLocalizations.of(context).translate("problem_message")),
        icon: Icon(
          Icons.info_outline,
          size: 28,
          color: Colors.blue.shade300,
        ),
        leftBarIndicatorColor: Colors.blue.shade300,
        duration: Duration(seconds: 3),
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      )..show(context);
      throw Exception();
    }
  }

  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId("112"),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(json.decode(
            widget.location)[AppLocalizations.of(context).translate("lang")]),
      ),
      body: GoogleMap(
        polylines: polyLines,
        markers: _markers,
        mapType: MapType.normal,
        onCameraMove: onCameraMove,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 05.08,
        ),
        onMapCreated: (GoogleMapController controller) {
          ctr.complete(controller);
          _markers.add(Marker(
            markerId: MarkerId("marker3"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(lat, lon),
            infoWindow: InfoWindow(
                title: json.decode(widget.location)[
                    AppLocalizations.of(context).translate("lang")],
                snippet: "go from here"),
          ));
          // polyLines.add(Polyline(
          //   polylineId: PolylineId("route1"),
          //   visible: true,
          //   color: Colors.red.shade600,
          //   startCap: Cap.roundCap,
          //   endCap: Cap.buttCap,
          // ));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          sendRequest();
        },
        label: Text('Destination!'),
      ),
    );
  }
}
