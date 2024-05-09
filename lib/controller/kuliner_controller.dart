import 'dart:convert';
import 'dart:io';

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
}