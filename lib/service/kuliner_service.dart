import 'dart:convert';

import 'package:http/http.dart' as http;

class KulinerService {
  final String baseUrl = 'http://10.0.2.2/kulinerApi/';
  final String endpoint = 'api.php';

  Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }

  Future<http.Response> addResto(Map<String, String> data) async {
    var request = http.MultipartRequest('POST', getUri(endpoint))
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'multipart/form-data';

    return await http.Response.fromStream(await request.send());
  }

  Future<List<dynamic>> getResto() async {
    var response = await http.get(
      getUri(endpoint),
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse;
    } else {
      throw Exception(
          'Failed to load wisata kuliner: ${response.reasonPhrase}');
    }
  }

  Future<List<dynamic>> fetchResto() async {
    var response = await http.get(
        getUri(
          endpoint,
        ),
        headers: {
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      final List<dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse;
    } else {
      throw Exception('Failed to load resto: ${response.reasonPhrase}');
    }
  }

  Future<http.Response> updateResto(Map<String, String> data, String id) async {
    var request = http.MultipartRequest(
      'PUT',
      getUri('$endpoint/$id'),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'multipart/form-data';

    return await http.Response.fromStream(await request.send());
  }

  Future<http.Response> deleteResto(String id) async {
    return await http.delete(getUri('$endpoint/$id'));
  }
}
