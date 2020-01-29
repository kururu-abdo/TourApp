import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:tourapp/Data/location_dao.dart';
import 'package:tourapp/DataSources/sqlite_data_base.dart';
import 'package:tourapp/DataSources/local_Data_sources.dart';
import 'package:tourapp/DataSources/remote_data_sources.dart';
import 'package:tourapp/Models/location_models.dart';
import 'package:tourapp/network/network_info.dart';

import 'package:meta/meta.dart';

class LocationProvider {
  RemoteContract remote;
  NetworkInfo net;
  LocalContract local;

  LocationProvider(
      {@required this.remote, @required this.net, @required this.local});
  Future<List<LocationModel>> getLocationType(String type) async {
    var dao = LocationDao();

    Future<List<LocationModel>> ls;
    if (await net.isConnected) {
      try {
        ls = remote.getLocationByType(type);
//TODO: git it

        //store.record(type).put(db,ls);
        List<LocationModel> data = await ls;
        Iterable locs = data;

        data.map((model) => local.cacheData(model));
        data.forEach((model) {
          local.cacheData(model);
        });

        return ls;
      } on Exception {
        throw Exception(" server failure");
      }
    } else {
//  ls =  Future.value( local.getLocationByType(type)  ) ;
      ls = local.getLocationByType(type);
      return ls;
    }
//  net.isConnected;
//  ls=   remote.getLocationByType(type);

//return ls ;
  }

  Future<List<LocationModel>> search(String str) async {
    var dao = LocationDao();
    bool result = await DataConnectionChecker().hasConnection;
/*  await net.isConnected */
    Future<List<LocationModel>> ls;
// String dbPath = 'locations.db';
// DatabaseFactory dbFactory = databaseFactoryIo;

// // We use the database factory to open the database
// Database db = await dbFactory.openDatabase(dbPath);
// var store= StoreRef.main();
    if (await net.isConnected) {
      try {
        ls = remote.search(str);

        //store.record(type).put(db,ls);

        return ls;
      } on Exception {
        throw Exception(" server failure");
      }
    } else {
      ls = local.search(str);
      return ls;
    }
//  net.isConnected;
//  ls=   remote.getLocationByType(type);

//return ls ;
  }

  Future<List<LocationModel>> getAllLocations() async {
    bool result = await DataConnectionChecker().hasConnection;
/*  await net.isConnected */
    Future<List<LocationModel>> ls;
    if (await net.isConnected) {
      try {
        ls = remote.getAllLocations();

        return ls;
      } on Exception {
        throw Exception(" server failure");
      }
    } else {
      var ls = local.getAllLocation();

      return ls;
    }
//  net.isConnected;
//  ls=   remote.getLocationByType(type);

//return ls ;
  }
}
