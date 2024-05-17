import 'package:exercise2/model/kuliner.dart';
import 'package:exercise2/widget/edit_form.dart';
import 'package:flutter/material.dart';

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
                  title: Text('Wisata Kuliner Jogja'),
                  subtitle: Text(kuliner.nama),
                ),
                ListTile(
                  title: Text('Akun Instagram Resto'),
                  subtitle: Text(kuliner.instagram),
                ),
                ListTile(
                  title: Text('Alamat Resto'),
                  subtitle: Text(kuliner.alamat),
                ),
                ListTile(
                  title: Text('Nomer Telepon Resto'),
                  subtitle: Text(kuliner.telepon),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 153, 236, 202),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  EditForm(
                kuliner: Kuliner(
                  id: kuliner.id,
                  nama: kuliner.nama,
                  instagram: kuliner.instagram,
                  alamat: kuliner.alamat,
                  telepon: kuliner.telepon,
                  ),
                )));
        },
        child: const Icon(
          Icons.edit,
        ),
      ),
    );
  }
}
