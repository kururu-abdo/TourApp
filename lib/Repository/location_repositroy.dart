import 'package:get_it/get_it.dart';
import 'package:tourapp/Data/location_provider.dart';
import 'package:tourapp/Models/location_models.dart';

import 'package:meta/meta.dart';

abstract class RepositoryContract {
  Future<List<LocationModel>> getLocationType(String type);
  Future<List<LocationModel>> getAllLocations();
  Future<List<LocationModel>> search(String str);
}

class Repository implements RepositoryContract {
  final LocationProvider provider;
  Repository({@required this.provider});
  Future<List<LocationModel>> getAllLocations() => provider.getAllLocations();

  Future<List<LocationModel>> getLocationType(String type) =>
      provider.getLocationType(type);

  @override
  Future<List<LocationModel>> search(String str) {
    // TODO: implement search
    return provider.search(str);
  }
}
