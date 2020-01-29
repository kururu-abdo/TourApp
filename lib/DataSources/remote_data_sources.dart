import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourapp/DataSources/local_Data_sources.dart';
import 'package:tourapp/Models/location_models.dart';
import 'package:tourapp/Utils/constaints.dart';
import 'package:meta/meta.dart';

abstract class RemoteContract {
  getLocationByType(String type);
  Future<List<LocationModel>> getAllLocations();

  Future<List<LocationModel>> search(String str);
}

class Remote implements RemoteContract {
  final LocalContract loc;
  final Client client;

  Remote({@required this.client, @required this.loc});

  @override
  Future<List<LocationModel>> getLocationByType(String type) async {
    try {
      var response = await client.get("$GET_TYPE_URL/location?type=$type");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Iterable l = json.decode(response.body);
        List<LocationModel> locations =
            l.map((model) => LocationModel.fromJson(model)).toList();

        return locations;
      } else {
        return loc.getLocationByType(type);
      }
     } on Exception {
      throw Exception("the are a problem with the internet or the server");
    }
  }

  Future<List<LocationModel>> getAllLocations() async {
    var response = await client.get("$GET_ALL_URL/location");

    if (response.statusCode == 200 || response.statusCode == 201) {
      Iterable l = json.decode(response.body);
      List<LocationModel> locations =
          l.map((model) => LocationModel.fromJson(model)).toList();

      return locations;
    } else {
      return loc.getAllLocation();
    }
  }

  @override
  Future<List<LocationModel>> search(String str) async {
    var response = await client.get("$SEARCH_URL/search?name=$str");

    if (response.statusCode == 200 || response.statusCode == 201) {
      Iterable l = json.decode(response.body);
      List<LocationModel> locations =
          l.map((model) => LocationModel.fromJson(model)).toList();

      return locations;
    } else {
      return loc.search(str);
    }
  }
}
