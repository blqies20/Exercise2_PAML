import 'dart:io';

import 'package:exercise2/controller/kuliner_controller.dart';
import 'package:exercise2/model/kuliner.dart';
import 'package:exercise2/screen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormKuliner extends StatefulWidget {
  const FormKuliner({super.key});

  @override
  State<FormKuliner> createState() => _FormKulinerState();
}

class _FormKulinerState extends State<FormKuliner> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _instagramController = TextEditingController();
  final _noTeleponController = TextEditingController();

  File? _image;
  final _imagePicker = ImagePicker();
  String? _alamat;

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Nama", hintText: "Masukkan Nama Tempat Kuliner"),
              controller: _namaController,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Instagram", hintText: "Masukkan Akun Instagram Tempat Kuliner"),
              controller: _instagramController,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Alamat"),
                _alamat == null
                    ? SizedBox(
                        width: double.infinity,
                        child: Text('Alamat Kosong'),
                      )
                    : Text('$_alamat'),
                _alamat == null
                    ? TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MapScreen(onLocationSeleced: (selectedAddress) {
                                setState(() {
                                  _alamat = selectedAddress;
                                });
                              }),
                            ),
                          );
                        },
                        child: Text('Pilih Alamat'),
                      )
                    : TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MapScreen(onLocationSeleced: (selectedAddress) {
                                setState(() {
                                  _alamat = selectedAddress;
                                });
                              }),
                            ),
                          );
                          setState(() {});
                        },
                        child: Text('Ubah Alamat'),
                      )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Nomer Telepon", hintText: "Masukkan nomer"),
              controller: _noTeleponController,
            ),
          ),
          _image != null ? Image.file(_image!) : Text("Tidak ada gambar"),
          ElevatedButton(
            onPressed: getImage,
            child: Text("Pilih gambar"),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  var result = await KulinerController().addWisata(
                      Kuliner(
                          nama: _namaController.text,
                          instagram: _instagramController.text,
                          alamat: _alamat ?? '',
                          telepon: _noTeleponController.text,
                          foto: _image!.path),
                      _image);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        result['message'],
                      ),
                    ),
                  );
                }
              },
              child: Text("Submit"),
            ),
          )
        ],
      )),
    );
  }
}