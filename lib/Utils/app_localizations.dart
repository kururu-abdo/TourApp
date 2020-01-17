import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

static const LocalizationsDelegate<AppLocalizations> delegate =
_AppLocalizationsDelegates(); 
static AppLocalizations of(BuildContext context){
  return Localizations.of<AppLocalizations>(context, AppLocalizations);
}
Map<String , String>  _localeString;

Future <bool>  load() async{
String jsonString = await rootBundle.loadString("lib/lang/${locale.languageCode}.json");
Map<String , dynamic>  jsonMap = json.decode(jsonString);

_localeString =jsonMap.map((key  , value){
return  MapEntry(
key ,  value.toString()
);
});
return true;
}

String translate(String key){
return _localeString[key];

}
String get title {
    return Intl.message('Hello world App',
        name: 'title', desc: 'The application title');
        }
  

}


class _AppLocalizationsDelegates  extends LocalizationsDelegate<AppLocalizations>{

  const _AppLocalizationsDelegates();
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ["en" ,"ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale)  async{
  AppLocalizations localizations =new AppLocalizations(locale);
  await localizations.load();
    return   localizations ;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }

}