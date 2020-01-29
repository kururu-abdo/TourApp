import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tourapp/network/network_info.dart';

class MockNetwork extends Mock implements NetworkInfo {}

void main() {
  MockNetwork mockNetwork;
  group('data connection checker', () {
    setUp(() {
      mockNetwork = MockNetwork();
    });

    test('check network connectivity', () async {
// arrange
      when(mockNetwork.isConnected).thenAnswer((_) async => false);

//act
      bool result = await mockNetwork.isConnected;

//assert

      // verify(mockNetwork.isConnected);
      expect(result, false);
    });
  });
}
