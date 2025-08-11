import 'package:http/http.dart' as http;

class HttpService {
  final http.Client client;

  HttpService({http.Client? client}) : client = client ?? http.Client();

  Future<http.Response> get(String url) async {
    return await client.get(Uri.parse(url));
  }

  // se pueden crear el post y el put
}
