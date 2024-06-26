import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ucp2_pam/model/kuliner.dart';
import 'package:ucp2_pam/service/kuliner_service.dart';

class KulinerController{
  final kulinerService = KulinerService();

     Future<Map<String, dynamic>> addKuliner(Kuliner kuliner, File? file) async {
    Map<String,String> data ={
      "nama": kuliner.nama,
      "lokasi": kuliner.lokasi,
      "deskripsi": kuliner.deskripsi,
    };
    try {
      var response = await kulinerService.addKuliner(data, file);
      if (response.statusCode == 201) {
        return {
          'success': true,
          "message": "Data berhasil disimpan",
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          print(response.body);
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            "message": decodedJson['message'] ?? 'Terjadi kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi kesalahan saat menyimpan data'
        };
      }
    } catch (e) {
      print(e);
      return {"success": false, "message": 'Terjadi kesalahan: $e'};
    }
  }
  Future<List<Kuliner>> getKuliner() async {
    try {
      List<dynamic> kulinerData = await kulinerService.fetchKuliner();
      List<Kuliner> kuliner =
          kulinerData.map((json) => Kuliner.fromMap(json)).toList();
      return kuliner;
    } catch (e) {
      print(e);
      throw Exception('Gagal Mendapatkan data Kuliner');
    }
  }

    Future<http.Response> deleteKuliner(String id) async {
    return await kulinerService.deleteKuliner(id);
  }

  Future<Map<String, dynamic>> updateKuliner(Kuliner kuliner, File? file) async {
    Map<String, String> data = {
      "nama": kuliner.nama,
      "lokasi": kuliner.lokasi,
      "deskripsi": kuliner.deskripsi,
    };

    try {
      var response =
          await kulinerService.updateKuliner(kuliner.id.toString(), data, file);
      if (response.statusCode == 200) {
        return {
          'success': true,
          "message": "Data berhasil diperbarui",
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            "message": decodedJson['message'] ?? 'Terjadi kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message': decodedJson['message'] ??
              'Terjadi kesalahan saat memperbarui data'
        };
      }
    } catch (e) {
      return {"success": false, "message": 'Terjadi kesalahan: $e'};
    }
  }

  Future<Kuliner> getKulinerById(int id) async {
    try {
      List<dynamic> kulinerData = await kulinerService.getkulinerByid(id);
      Kuliner kuliner = kulinerData.map((json) => Kuliner.fromMap(json)).first;
      return kuliner;
    } catch (e) {
      print(e);
      throw Exception('Gagal Mendapatkan data Kuliner');
    }
  }
}