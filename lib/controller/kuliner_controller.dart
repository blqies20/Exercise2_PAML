import 'dart:convert';
import 'dart:io';

import 'package:exercise2/model/kuliner.dart';
import 'package:exercise2/service/kuliner_service.dart';
import 'package:mysql1/mysql1.dart';

class KulinerController {
  final kulinerService = KulinerService();

  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';
  final String _password = 'Dubaddu05_';
  final String _databaseName = 'kuliner';

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
    final connectionSettings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      db: _databaseName,
      password: _password,
    );

    final MySqlConnection connection =
        await MySqlConnection.connect(connectionSettings);

    try {
      final results = await connection.query('SELECT * FROM KULINER');

      final kulinerList = results
          .map((row) => Kuliner(
                nama: row[0],
                instagram: row[1],
                alamat: row[2],
                telepon: row[3],
                foto: row[4],
              ))
          .toList();

      List<dynamic> restoData = await kulinerService.fetchResto();
      List<Kuliner> resto =
          restoData.map((json) => Kuliner.fromMap(json)).toList();
      return resto;
    } catch (e) {
      print(e);
      throw Exception('Failed to get resto');
    } finally {
      await connection.close();
    }
  }
}
