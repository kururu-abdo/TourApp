import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';


class AppDatabase{
static final AppDatabase _singleton =  AppDatabase._();


static  AppDatabase get instance => _singleton;


Completer<Database> _dbOpenCompleter;

AppDatabase._();

Future<Database> get database async{
if(_dbOpenCompleter== null){
  _dbOpenCompleter=Completer();

  _openCompleter();
}
await _dbOpenCompleter.future;


}
Future _openCompleter() async{
 io.Directory AppDocumentDir = await getApplicationDocumentsDirectory();
final dbPath =join(AppDocumentDir.path ,"mydata.db");


final database =await databaseFactoryIo.openDatabase(dbPath);
_dbOpenCompleter.complete(database);
await _dbOpenCompleter.future;
}






}