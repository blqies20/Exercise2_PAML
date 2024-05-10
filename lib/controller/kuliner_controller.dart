import 'dart:convert';
import 'dart:io';

import 'package:exercise2/model/kuliner.dart';
import 'package:exercise2/service/kuliner_service.dart';
import 'package:http/http.dart';

class KulinerController {
  final KulinerService _service = KulinerService();

  Future<Map<String, dynamic>> addWisata(Kuliner wisata, File? file) async {
    Map<String, String> data = {
      'nama': wisata.nama,
      'alamat': wisata.alamat,
      'instagram': wisata.instagram,
      'telepon': wisata.telepon
    };
    try {
      var response = await _service.addResto(data, file);

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
      List<dynamic> restoData = await _service.fetchResto();
      List<Kuliner> resto =
          restoData.map((json) => Kuliner.fromMap(json)).toList();
      return resto;
    } catch (e) {
      print('Response: $Response');
      print('Exception: $e');
      throw Exception('Failed to get resto');
    }
  }

  Future<Map<String, dynamic>> editResto(
      Kuliner kuliner, File? file, String id) async {
    Map<String, String> data = {
      'nama': kuliner.nama,
      'instagram': kuliner.instagram,
      'alamat': kuliner.alamat,
      'telepon': kuliner.telepon,
    };

    try {
      var response = await _service.editResto(data, file, id);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Data berhasil diubah',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'Terjadi kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi Kesalahan saat mengubah data',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<Map<String, dynamic>> deleteResto(String id) async {
    try {
      var response = await _service.deleteResto(id);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Data berhasil dihapus',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'Terjadi Kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi Kesalahan saat menghapus data',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}
