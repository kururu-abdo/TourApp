import 'package:get_it/get_it.dart';
import 'package:tourapp/Data/location_provider.dart';
import 'package:tourapp/Models/location_models.dart';
abstract class RepositoryContract{
  Future<List<LocationModel> >  getLocationType(String type);
  Future<List<LocationModel> >  getAllLocations();
}
class Repository implements RepositoryContract{
final provider =GetIt.instance.get<LocationProvider>(); 

Future<List<LocationModel> >  getAllLocations()=>provider.getAllLocations();

Future<List<LocationModel> >  getLocationType(String type)=>provider.getLocationType(type);
}