import 'package:exercise2/controller/kuliner_controller.dart';
import 'package:exercise2/model/kuliner.dart';
import 'package:exercise2/screen/detail_screen.dart';
import 'package:exercise2/widget/edit_form.dart';
import 'package:exercise2/widget/kuliner_form.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final KulinerController _controller = KulinerController();

  @override
  void initState(){
    super.initState();
    _controller.getResto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kuliner Jogja"),
      ),
      body: FutureBuilder<List<Kuliner>>(
        future: _controller.getResto(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Kuliner kuliner = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                              kuliner: Kuliner(
                                  id: kuliner.id,
                                  nama: kuliner.nama,
                                  instagram: kuliner.instagram,
                                  alamat: kuliner.alamat,
                                  telepon: kuliner.telepon)),
                        ));
                  },
                  child: ListTile(
                    title: Text(kuliner.nama),
                    subtitle: Text(kuliner.instagram),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditForm(
                                            kuliner: Kuliner(
                                          id: kuliner.id,
                                          nama: kuliner.nama,
                                          instagram: kuliner.instagram,
                                          alamat: kuliner.alamat,
                                          telepon: kuliner.telepon,
                                        ))));
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      title: Text('Hapus data ini?'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              await _controller.deleteResto(
                                                  kuliner.id! as String);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Hapus')),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Batal')),
                                      ],
                                    );
                                  }));
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormKuliner()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
