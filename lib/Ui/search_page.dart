import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tourapp/Bloc/location_bloc.dart';
import 'package:tourapp/Models/location_models.dart';
import 'package:tourapp/Ui/detail_page.dart';
import 'package:tourapp/Utils/app_localizations.dart';
import 'package:tourapp/Utils/constaints.dart';
import 'package:tourapp/Utils/location_routes.dart';
import 'package:tourapp/main.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
List<LocationModel> sugestedList= new List<LocationModel>();
  var bloc= LocationBloc();
  final SearchBarController<LocationModel> _searchBarController = SearchBarController();
  bool isReplay = false;
    List<LocationModel> locations=List<LocationModel>() ;

  Future<List<LocationModel>> _getALLocations(String text) async {
 await Future.delayed(Duration(seconds: 2));
    
    Client client =new Client();
final response = await client.get('$SEARCH_URL/search?name=$text');

Iterable l = json.decode(response.body);
List<LocationModel> locations = l.map(( model)=> LocationModel.fromJson(model)).toList();


   
    
   







  return List.generate(locations.length, (int index) {


    return LocationModel(
lat: locations[index].lat,
longitude:locations[index].longitude ,
      
     locationName :locations[index].locationName,
          state :locations[index].state,
          type: locations[index].type ,
           description: locations[index].description ,
           
 pic: locations[index].pic ,
    
    );
  });
    
  }
@override
  void dispose() {

    bloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
   return  Scaffold(
    
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<LocationModel>(
            suggestions: [LocationModel(locationName: "darfour") ,LocationModel(locationName: "kauda")],
            loader: Text(AppLocalizations.of(context).translate("loading")),
           
            minimumChars: 1,
indexedScaledTileBuilder: (int index) => ScaledTile.count(
  index % 3 == 0 ? 2 : 1,
  1,
),
buildSuggestion: (LocationModel model  , int index){
Text(json.encode(model.locationName))  ;
},
hintText:AppLocalizations.of(context).translate("floppy_search_hint"),
cancellationText: Text(AppLocalizations.of(context).translate("search_cancel")),
hintStyle: TextStyle(
  color: Colors.grey[100],
),
textStyle: TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
),
mainAxisSpacing: 10,
crossAxisSpacing: 10,

            onSearch: _getALLocations,
            onItemFound: (LocationModel model, int index) {
              return Container(
      
        child: Card(
          color: Colors.pink[900],
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            
  crossAxisAlignment: CrossAxisAlignment.center ,
             children: [
           
            //snapshot.data.locations[index]

            
            Text(
            json.decode(model.locationName)[AppLocalizations.of(context).translate("lang")] +
                  "\n" +
                json.decode(model.state)[AppLocalizations.of(context).translate("lang")],
              style:
                  TextStyle( fontStyle: FontStyle.italic ,fontWeight: FontWeight.bold),
            ),
                          
            FutureBuilder(
              future: bloc.getDestince(model.lat,
                 model.longitude),
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
                            child:  Text(AppLocalizations.of(context).translate("map_button") ,
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
Routes.sailor.navigate(
          '/map',
          params: {
            'lat': model.lat,
            'longitude': model.longitude,
            "location": model.locationName
          });


                            },
                          ),
                          FlatButton(
                       color: Colors.pinkAccent,     
                            child:  Text(AppLocalizations.of(context).translate("detail_button"),
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {


Routes.sailor.navigate(
'/detail',
          params: {
            'desc':model.description,
            'pic': model.pic,
           
          });

                              
                            },
                          ),
                        ],
                      ),
                    )
                  ]) ,
               
       ),
        );

            },
          ),
        ),
      ),
    );
    
  }
}