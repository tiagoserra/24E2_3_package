import 'package:http/http.dart' as http;

class FirebaseProvider {

  static Future<String> httpPost(String url, String resource, String data) async {
    Uri uri = Uri.parse("$url$resource.json");

    http.Response res = await http.post(uri, body: data);

    return res.body;
  }

  static Future<String> httpGet(String url, String resource) async {
    Uri uri = Uri.parse("$url$resource.json");

    http.Response res = await http.get(uri);

    return res.body;
  }

  static Future<String> httpPut(String url, String resource, String data) async {
    Uri uri = Uri.parse("$url$resource.json");

    http.Response res = await http.put(uri, body: data);

    return res.body;
  }

  static Future<String> httpDelete(String url, String resource) async {
    Uri uri = Uri.parse("$url$resource.json");

    http.Response res = await http.delete(uri);

    return res.body;
  }
}
