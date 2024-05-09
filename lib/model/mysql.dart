import 'dart:async';

import 'package:mysql1/mysql1.dart';

Future<void> main() async {
  final databaseUrl = 'localhost';
  final databasePort = 3306;
  final databaseUsername = 'root';
  final databasePassword = 'Dubaddu05_';
  final databaseName = 'kuliner';

  final connectionSettings = ConnectionSettings(
    host: databaseUrl,
    port: databasePort,
    user: databaseUsername,
    db: databaseName,
    password: databasePassword,
  );

  final MySqlConnection connection = await MySqlConnection.connect(connectionSettings);

  try {
    await createDataTable(connection);
    await insertData(connection);
    await queryData(connection);
    await updateData(connection);
    await queryData(connection);
  } catch (e) {
    print('Error: $e');
  } finally {
    await connection.close();
  }
}

Future<void> createDataTable(MySqlConnection connection) async {
  final createTableQuery = '''
    CREATE TABLE data (
      id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
      nama varchar(50),
      instagram varchar(50),
      alamat varchar(255),
      telepon varchar(15),
      gambar blob
    )
  ''';

  await connection.query(createTableQuery);
}

Future<void> insertData(MySqlConnection connection) async {
  final insertQuery = '''
    INSERT INTO data (nama, instagram, alamat, telepon, gambar) VALUES (?,?,?,?,?)
  ''';

  final result = await connection.query(insertQuery, [
    'Bob', 
    '@bobby123', 
    '123 Main St', 
    '555-555-5555', 
    'picture_data'
  ]);
  print('Inserted row id=${result.insertId}');
}

Future<void> queryData(MySqlConnection connection) async {
  final query = '''
    SELECT nama, instagram, alamat, telepon, gambar FROM data WHERE id =?
  ''';

  final results = await connection.query(query, [1]);
  for (final row in results) {
    print('Nama: ${row[0]}, instagram: ${row[1]}, alamat: ${row[2]}, no_telepon: ${row[3]}, gambar: ${row[4]}');
  }
}

Future<void> updateData(MySqlConnection connection) async {
  final updateQuery = '''
    UPDATE data SET 
      nama =?, 
      instagram =?, 
      alamat =?, 
      telepon =?, 
      gambar =?
    WHERE nama =?
  ''';

  await connection.query(updateQuery, [
    'New Nama', 
    'new_instagram', 
    'new_alamat', 
    'new_telepon', 
    'new_gambar', 
    'Bob'
  ]);
}