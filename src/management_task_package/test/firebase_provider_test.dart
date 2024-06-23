import 'package:flutter_test/flutter_test.dart';
import 'package:management_task_package/providers/firebase_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// run=> flutter pub run build_runner build
import 'mocks/firebase_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('FirebaseProvider', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('httpPost returns response body', () async {
      const url = 'https://example.com';
      const resource = '/test';
      const data = '{"key": "value"}';
      final uri = Uri.parse('$url$resource.json');

      when(mockClient.post(uri, body: data))
          .thenAnswer((_) async => http.Response('{"response": "ok"}', 200));

      final response = await FirebaseProvider.httpPost(url, resource, data);

      expect(response, '{"response": "ok"}');
    });

    test('httpGet returns response body', () async {
      const url = 'https://example.com';
      const resource = '/test';
      final uri = Uri.parse('$url$resource.json');

      when(mockClient.get(uri))
          .thenAnswer((_) async => http.Response('{"response": "ok"}', 200));

      final response = await FirebaseProvider.httpGet(url, resource);

      expect(response, '{"response": "ok"}');
    });

    test('httpPut returns response body', () async {
      const url = 'https://example.com';
      const resource = '/test';
      const data = '{"key": "value"}';
      final uri = Uri.parse('$url$resource.json');

      when(mockClient.put(uri, body: data))
          .thenAnswer((_) async => http.Response('{"response": "ok"}', 200));

      final response = await FirebaseProvider.httpPut(url, resource, data);

      expect(response, '{"response": "ok"}');
    });

    test('httpDelete returns response body', () async {
      const url = 'https://example.com';
      const resource = '/test';
      final uri = Uri.parse('$url$resource.json');

      when(mockClient.delete(uri))
          .thenAnswer((_) async => http.Response('{"response": "ok"}', 200));

      final response = await FirebaseProvider.httpDelete(url, resource);

      expect(response, '{"response": "ok"}');
    });
  });
}