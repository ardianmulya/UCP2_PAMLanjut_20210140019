import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class KulinerService {

  final String baseUrl = 'http://192.168.224.122/api/';
  final String endpoint = 'kuliner';

    Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }
  Future<http.Response> addKuliner(Map<String, String> data, File? file) async {
    var request = http.MultipartRequest(
      'POST',
      getUri(endpoint),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'application/json';

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('foto', file.path));
    } else {
      request.files.add(http.MultipartFile.fromString('foto', ''));
    }

    return await http.Response.fromStream(await request.send());
  }

    Future<List<dynamic>> fetchKuliner() async {
    var response = await http.get(
        getUri(
          endpoint,
        ),
        headers: {
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse['kuliner'];
    } else {
      throw Exception('Tidak dapat mengambil data: ${response.reasonPhrase}');
    }
  }

    Future<http.Response> deleteKuliner(String id) async {
    return await http.delete(
      getUri('$endpoint/$id'),
      headers: {
        "Accept": "application/json",
      },
    );
  }
    Future<http.Response> updateKuliner(
      String id, Map<String, String> data, File? file) async {
    var request = http.MultipartRequest(
      'PUT',
      getUri('$endpoint/$id'),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'application/json';

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('gambar', file.path));
    }

    return await http.Response.fromStream(await request.send());
  }
    Future<List<dynamic>> getkulinerByid(int id) async {
    var response = await http.get(
        getUri(
          '$endpoint/$id',
        ),
        headers: {
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeResponse = json.decode(response.body);
      return decodeResponse['kuliner'];
    } else {
      throw Exception('Failed to load Kuliner : ${response.reasonPhrase}');
    }
  }

}