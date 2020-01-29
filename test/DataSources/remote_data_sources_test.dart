import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tourapp/DataSources/local_Data_sources.dart';
import 'package:tourapp/DataSources/remote_data_sources.dart';
import 'package:http/http.dart' as http;

class MockRemote extends Mock implements RemoteContract {}

class MockHttpClient extends Mock implements http.Client {}

class MockLocal extends Mock implements LocalContract {}

void main() {
  MockRemote mockRemote;
  Remote remote;

  setUp(() {
    mockRemote = MockRemote();
  });
  group('get data from the internet', () {
    setUp(() {
      mockRemote = MockRemote();
    });
  });
}
