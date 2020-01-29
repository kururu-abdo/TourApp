import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tourapp/Data/location_provider.dart';
import 'package:tourapp/DataSources/local_Data_sources.dart';
import 'package:tourapp/DataSources/remote_data_sources.dart';
import 'package:tourapp/Models/location_models.dart';
import 'package:tourapp/Repository/location_repositroy.dart';
import 'package:tourapp/network/network_info.dart';
import 'package:http/http.dart' as http;

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

  group('the device is online  ', () {
    setUp(() {
      when(network.isConnected).thenAnswer((_) async => true);
    });
    test('should return data from the remote sources', () async {
      when(remote.getLocationByType(type))
          .thenAnswer((_) async => List<LocationModel>());

// act
      var result = await provider.getLocationType(type);

      verify(remote.getLocationByType(type));
      expect(result, List<LocationModel>());
    });

    String str = "mesums";
    test('search about specific loction', () async {
      when(remote.search(str)).thenAnswer((_) async => List<LocationModel>());

// act
      var result = await provider.search(str);

      verify(remote.search(str));
      expect(result, List<LocationModel>());
    });

    test('get all location from the remote sources', () async {
      when(remote.getAllLocations())
          .thenAnswer((_) async => List<LocationModel>());

// act
      var result = await provider.getAllLocations();

      verify(remote.getAllLocations());
      expect(result, List<LocationModel>());
    });
  });

  group('the device is offline ', () {
    setUp(() {
      when(network.isConnected).thenAnswer((_) async => false);
    });

    test('get location by the type from the local sources', () async {
      when(local.getLocationByType(type))
          .thenAnswer((_) async => List<LocationModel>());

//act
      var result = await provider.getLocationType(type);

//the assert part

      verify(local.getLocationByType(type));
      expect(result, List<LocationModel>());
    });
  });
}
