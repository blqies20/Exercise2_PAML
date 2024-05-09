import 'dart:convert';
import 'dart:io';

import 'package:exercise2/model/kuliner.dart';
import 'package:exercise2/service/kuliner_service.dart';

class KulinerController {
  final kulinerService = KulinerService();

  Future<Map<String, dynamic>> addWisata(Kuliner wisata, File? file) async {
    Map<String, String> data = {
      'nama': wisata.nama,
      'alamat': wisata.alamat,
      'telepon': wisata.telepon
    };
    try {
      var response = await kulinerService.addWisata(data, file);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Data berhasil disimpan',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodeJson = jsonDecode(response.body);

          return {
            'success': false,
            'message': decodeJson['message'] ?? 'Terjadi kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi kesalahan saat menyimpan data',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<List<Kuliner>> getResto() async {
    try {
      List<dynamic> restoData = await kulinerService.fetchResto();
      List<Kuliner> resto =
          restoData.map((json) => Kuliner.fromMap(json)).toList();
      return resto;
    } catch (e) {
      print(e);
      throw Exception('Failed to get resto');
    }
  }
}
