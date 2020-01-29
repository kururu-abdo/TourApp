import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tourapp/Data/location_provider.dart';
import 'package:tourapp/DataSources/local_Data_sources.dart';
import 'package:tourapp/DataSources/remote_data_sources.dart';
import 'package:tourapp/Models/location_models.dart';
import 'package:tourapp/Repository/location_repositroy.dart';
import 'package:http/http.dart' as http;
import 'package:tourapp/network/network_info.dart';

class MockRepository extends Mock implements Repository {}

class MockLocal extends Mock implements LocalContract {}

class MockRemote extends Mock implements RemoteContract {}

class MockNetwork extends Mock implements NetworkInfo {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockRepository repo;
  MockLocal local;
  MockNetwork network;
  MockRemote remote;
  MockHttpClient mockHttpClient;
  LocationProvider provider;

  setUp(() {
    repo = MockRepository();
    local = MockLocal();
    remote = MockRemote();
    network = MockNetwork();
    mockHttpClient = MockHttpClient();
    provider = LocationProvider(net: network, local: local, remote: remote);
  });
  String location_name = "khartoum";
  int location_id = 67;
  String state = "khartoum";
  String type = "mesums";
  String desc = "this is a nice place to live in";
  String pic = "base46 Encoded image ";
  double lat = 16.95845;
  double lon = 32.535;

  var loc = LocationModel(
      locationId: location_id,
      locationName: location_name,
      state: state,
      type: type,
      description: desc,
      pic: pic,
      lat: lat,
      longitude: lon);
  test('check connectivity to the internet', () async {
//arrange

    when(network.isConnected).thenAnswer((_) async => true);

// act

    repo.getLocationType(type);

//assert
    //expect(result, List<LocationModel>());

    verifyNever(network.isConnected);
  });

  test('get location by the type', () async {
//arrange
    when(repo.getLocationType(type))
        .thenAnswer((_) async => List<LocationModel>());

    // act
    final result = await repo.getLocationType(type);

    //assert

    expect(result, equals(List<LocationModel>()));
  });
  test('get all locations by the type', () async {
//arrange
    when(repo.getAllLocations()).thenAnswer((_) async => List<LocationModel>());

    // act
    final result = await repo.getAllLocations();

    //assert

    expect(result, equals(List<LocationModel>()));
  });
}
