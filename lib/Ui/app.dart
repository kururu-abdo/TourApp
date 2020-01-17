import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:tourapp/Utils/app_localizations.dart';
import 'package:tourapp/Utils/location_routes.dart';

import '../main.dart';
import 'my_app.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Material(
child: MaterialApp(
        supportedLocales: [
          const Locale('ar', ''), // Arabic
          const Locale('en', 'US'),
        ],
      
        localizationsDelegates: [
          
        AppLocalizations.delegate ,
           GlobalMaterialLocalizations.delegate,

          GlobalMaterialLocalizations.delegate ,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale ,supportedLocales){
          for(var supportedLocale in supportedLocales){
            if(supportedLocale.countryCode == locale.countryCode &&  supportedLocale.languageCode==locale.languageCode){
              return supportedLocale;
            }

          }
          return supportedLocales.first;
        },
         onGenerateRoute: Routes.sailor.generator(),
        navigatorKey: Routes.sailor.navigatorKey,
        theme: ThemeData(
          backgroundColor: Colors.teal[500],
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
            accentColor:Colors.pinkAccent[400],
            brightness: Brightness.dark ,
                fontFamily: 'Georgia',
textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
            
            
            ) ,
home: I18n(child: MyApp()),
)
    );
  }


}