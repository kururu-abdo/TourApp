import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:tourapp/Bloc/location_bloc.dart';
import 'package:tourapp/Bloc/location_event.dart';

import 'package:tourapp/Models/location_models.dart';
import 'package:tourapp/Ui/location.dart';

import 'package:tourapp/Ui/search_page.dart';
import 'package:tourapp/Utils/app_localizations.dart';
import 'package:tourapp/Utils/location_routes.dart';
import './Utils/dependency_inversion.dart' as di;
import 'package:path_provider/path_provider.dart' as path_provider;

import 'Ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(LocationModelAdapter(), 0);

  Routes.createRoutes();
  await di.init();

  final locationsBox = await Hive.openBox('locations');
  final mesumsBox = await Hive.openBox('mesums');
  final pyramidsBox = await Hive.openBox('pyramids');
  final otherBox = await Hive.openBox('other');

  runApp(App());
}
