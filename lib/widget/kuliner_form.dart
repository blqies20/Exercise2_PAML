import 'package:exercise2/controller/kuliner_controller.dart';
import 'package:exercise2/model/kuliner.dart';
import 'package:exercise2/screen/homeview.dart';
import 'package:exercise2/screen/map_screen.dart';
import 'package:flutter/material.dart';

class FormKuliner extends StatefulWidget {
  const FormKuliner({super.key});

  @override
  State<FormKuliner> createState() => _FormKulinerState();
}

class _FormKulinerState extends State<FormKuliner> {
  final _formKey = GlobalKey<FormState>();
  final kulinerKontroller = KulinerController();
  final _namaController = TextEditingController();
  final _instagramController = TextEditingController();
  final _teleponController = TextEditingController();

  String? _alamat;
  get _id => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Resto Jogja'),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Nama",
                        hintText: "Masukkan Nama Tempat Kuliner"),
                    controller: _namaController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Instagram",
                        hintText: "Masukkan Akun Instagram Tempat Kuliner"),
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
                                    builder: (context) => MapScreen(
                                        onLocationSelected: (selectedAddress) {
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
                                    builder: (context) => MapScreen(
                                        onLocationSelected: (selectedAddress) {
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
                        labelText: "Nomer Telepon",
                        hintText: "Masukkan Nomer Telepon Tempat Kuliner"),
                    controller: _teleponController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        var result = await kulinerKontroller.addResto(
                          Kuliner(
                            id: _id,
                            nama: _namaController.text,
                            instagram: _instagramController.text,
                            telepon: _teleponController.text,
                            alamat: _alamat ?? '',
                          ),
                        );

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result['message'])),
                        );

                        Navigator.pushAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()),
                            (route) => false);
                      }
                    },
                    child: Text("Submit"),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
