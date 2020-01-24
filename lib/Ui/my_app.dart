import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tourapp/Bloc/location_bloc.dart';
import 'package:tourapp/Ui/location.dart';
import 'package:tourapp/Ui/search_page.dart';
import 'package:tourapp/Utils/app_localizations.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;
  static final types = ["mesums", "pyramids", "other"];
  ScrollController _scrollController;
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio(); // for http requests
  String _searchText = "";
  List locations = new List(); // names we get from API
  List filteredLocations = new List(); // names filtered by search text

  Widget _appBarTitle = new Text('tour app');

  String _selected = types[0];
  int currentIndex = 0;

  @override
  void dispose() {
    tabController.dispose();
    _scrollController.dispose();
    Hive.box('locations').compact();
    Hive.box('mesums').compact();
    Hive.box('pyramids').compact();
    Hive.box('other').compact();
    Hive.close();
    _filter.dispose();
    super.dispose();
  }

  void tapUpdate() {
    setState(() {
      currentIndex = tabController.index;
    });
  }

  void _selectedType(String type) {
    setState(() {
      tabController.index = types.indexOf(type);
      currentIndex = types.indexOf(type);
      _selected = type;
    });
  }

  @override
  void initState() {
    _scrollController = new ScrollController();
    tabController = new TabController(length: 3, vsync: this);
    // bloc.fetchLocationsByType("other");
    tabController.addListener(tapUpdate);

    // TODO: implement
    super.initState();
  }

  Future<bool> alert() {
    return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                      AppLocalizations.of(context).translate("alert_title")),
                  content: Text(
                      AppLocalizations.of(context).translate("alert_text")),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                          AppLocalizations.of(context).translate("yes_button")),
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                        /*  Navigator.of(context).pop(true);  */
                      },
                    ),
                    FlatButton(
                      child: Text(
                          AppLocalizations.of(context).translate("no_button")),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ],
                )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        alert();
      },
      child: BlocProvider(
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName:
                      Text(AppLocalizations.of(context).translate("appTitle")),
                  accountEmail: Text("students-dev@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.blue
                            : Colors.white,
                    child: Image.asset("lib/assets/images/icon2.jpg"),
                  ),
                ),
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  title:
                      Text(AppLocalizations.of(context).translate("tab1Title")),
                  onTap: () {
                    _selectedType(types[0]);

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  title:
                      Text(AppLocalizations.of(context).translate("tab2Title")),
                  onTap: () {
                    _selectedType(types[1]);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  title:
                      Text(AppLocalizations.of(context).translate("tab2Title")),
                  onTap: () {
                    _selectedType(types[2]);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverAppBar(
                    centerTitle: true,
                    actions: <Widget>[
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return types.map((loc) {
                            return PopupMenuItem(
                              value: loc,
                              child: ListTile(
                                title: Text(AppLocalizations.of(context)
                                    .translate(
                                        "tab${types.indexOf(loc) + 1}Title")),
                              ),
                            );
                          }).toList();
                        },
                        onSelected: _selectedType,
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Search()));
                        },
                      )
                    ],

                    title: new Text(
                        AppLocalizations.of(context).translate("appTitle")),

                    //new Text(AppLocalizations.of(context).translate("appTitle"))
                    pinned: true,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      controller: tabController,
                      tabs: <Widget>[
                        Tab(
                          icon: Icon(Icons.looks_one),
                          text: AppLocalizations.of(context)
                              .translate("tab1Title"),
                        ),
                        Tab(
                          icon: Icon(Icons.looks_two),
                          text: AppLocalizations.of(context)
                              .translate("tab2Title"),
                        ),
                        Tab(
                          icon: Icon(Icons.looks_3),
                          text: AppLocalizations.of(context)
                              .translate("tab3Title"),
                        )
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: tabController,

//   children:[
// Muesums() ,
// Pyramids() ,
// Others()
                //]
                children: types.map((f) {
                  return Location(
                    locationType: f,
                  );
                }).toList(),
              ),
            ),
          ),

          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: currentIndex,
          //   onTap: (index) {
          //     setState(() {
          //       _selectedType(types[index]);
          //     });
          //   },
          //   items: [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.looks_one),
          //       title: Text(types[0]),
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.looks_two),
          //       title: Text(types[1]),
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.looks_3),
          //       title: Text(types[2]),
          //     )
          //   ],
          // ),
        ),
        blocs: [
          Bloc((i) => LocationBloc()),
        ],
      ),
    );
  }
}
