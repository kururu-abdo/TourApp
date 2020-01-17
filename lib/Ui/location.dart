import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong/latlong.dart';

import 'package:sailor/sailor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourapp/Bloc/location_bloc.dart';
import 'package:tourapp/Models/location_models.dart';
import 'package:tourapp/Repository/location_repositroy.dart';
import 'package:tourapp/Ui/detail_page.dart';
import 'package:tourapp/Ui/shimmer_list_item.dart';
import 'package:tourapp/Utils/app_localizations.dart';
import 'package:tourapp/Utils/location_routes.dart';
import 'package:tourapp/Utils/location_services.dart';
import 'package:tourapp/presentation/my_flutter_app_icons.dart';

class Location extends StatefulWidget {
  Location({Key key, @required this.locationType}) : super(key: key);

  final locationType;

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  var bloc = BlocProvider.getBloc<LocationBloc>();
  List<LocationModel> locs = List<LocationModel>();
  List<LocationModel> locationToDisplay = List<LocationModel>();

  Future<List<LocationModel>> fetchLocatios() async {
    var locations = await bloc.fetchSpecificType(widget.locationType);

    return locations;
  }

  void initState() {
    fetchLocatios().then((value) {
      setState(() {
        locs.addAll(value);
        locationToDisplay = locs;
      });
    });
    // bloc.fetchLocationsByType("other");
    bloc.fetchLocationsByType(widget.locationType);

    // TODO: implement
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LocationModel>>(
      stream: bloc.locationType,
      builder: (context, AsyncSnapshot<List<LocationModel>> snapshot) {
        if (!snapshot.hasData) {
          return ListView.builder(
              itemCount: 10,
              // Important code
              itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.white,
                    child: ListItem(index: -1),
                  ));
          // Center(
          //     child: CircularProgressIndicator(
          //   semanticsLabel: "loading",
          // ));
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return locationList(snapshot);
      },
    );
  }

  Widget locationList(AsyncSnapshot<List<LocationModel>> snapshot) {
    var locations = snapshot.data;
    return ListView.builder(
      itemCount: locationToDisplay.length + 1,
      itemBuilder: (BuildContext context, int index) {
        print("inside data channel");
        return index == 0 ? _searchbar(locations) : _locationList(index - 1);
      },
    );
  }

  _searchbar(locations) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText:AppLocalizations.of(context).translate("search_text")),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            locationToDisplay = locs.where((location) {
              var title = location.locationName.toLowerCase();
              return title.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _locationList(int index) {
    return Container(
      
        child: Card(
          color: Colors.teal,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              
           
            //snapshot.data.locations[index]

            
            Text(
              locationToDisplay[index].locationName  ,
               style:
                  TextStyle( fontStyle: FontStyle.italic ,fontSize: 10.0 ),
                ) ,
                  Text(
                locationToDisplay[index].state ,
               style:
                  TextStyle( fontStyle: FontStyle.italic ,fontSize: 10.0),
                ) ,
                  
            
//
//          PhotoView(
//imageProvider: MemoryImage((base64.decode(locationToDisplay[index].pic)),
//
//
//          ) ,
//
//                    initialScale: PhotoViewComputedScale.contained * 0.8,
//                     maxScale: PhotoViewComputedScale.covered * 2,
//        enableRotation: true,
//        // Set the background color to the "classic white"
//        backgroundDecoration: BoxDecoration(
//          color: Theme.of(context).canvasColor,
//        ),
//        loadingChild: Center(
//          child: CircularProgressIndicator(),
//        ),
//
//
//           ) ,
           
            
Image.memory(base64.decode(locationToDisplay[index].pic) )    ,
              
              
              
            FutureBuilder(
              future: bloc.getDestince(locationToDisplay[index].lat,
                  locationToDisplay[index].longitude),
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.hasData) {
                  return Row(children: [
                    Icon(snapshot.data >= 800.0
                        ? Icons.airplanemode_active
                        : MdiIcons.car),
                    Text(AppLocalizations.of(context).translate("distance")),
                    Text(snapshot.data.toString() + AppLocalizations.of(context).translate("kilo"))]);
                     }
                      else {
                  return CircularProgressIndicator();
                }
              },
            ),


                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            color: Colors.pinkAccent,  
                            child:  Text(AppLocalizations.of(context).translate("map_button"),
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
Routes.sailor.navigate(
          '/map',
          params: {
            'lat': locationToDisplay[index].lat,
            'longitude': locationToDisplay[index].longitude,
            "location": locationToDisplay[index].locationName
          });


                            },
                          ),
                          FlatButton(
                       color: Colors.pinkAccent,     
                            child:  Text(  AppLocalizations.of(context).translate("detail_button"),
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {


Routes.sailor.navigate(
'/detail',
          params: {
            'desc': locationToDisplay[index].description,
            'pic': locationToDisplay[index].pic,
           
          });

                              
                            },
                          ),
                        ],
                      ),
                    )
                  ]) ,
               
       ),
        );

      
       
        }
        
      } 
    
      
    
  

  
