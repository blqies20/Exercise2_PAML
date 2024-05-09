import 'package:exercise2/controller/kuliner_controller.dart';
import 'package:exercise2/model/kuliner.dart';
import 'package:exercise2/screen/input_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final KulinerController _controller = KulinerController();

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
                return ListTile(
                  title: Text(kuliner.nama),
                  subtitle: Text(kuliner.instagram),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(kuliner.foto),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InputView()));
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
