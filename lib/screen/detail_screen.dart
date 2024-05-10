import 'package:exercise2/model/kuliner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.kuliner,
  });

  final Kuliner kuliner;

  @override
  State<DetailScreen> createState() => _DetailScreenState(kuliner);
}

class _DetailScreenState extends State<DetailScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController telepon = TextEditingController();
  ImagePicker gambar = ImagePicker();

  Kuliner kuliner;
  _DetailScreenState(this.kuliner);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Wisata Kuliner'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 12,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Gambar Wisata Kuliner'),
                  subtitle: Image(
                      image: NetworkImage(kuliner.foto),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover),
                ),
                ListTile(
                  title: Text('Wisata Kuliner Jogja'),
                  subtitle: Text(kuliner.nama),
                ),
                ListTile(
                  title: Text('Alamat Resto'),
                  subtitle: Text(kuliner.alamat),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
