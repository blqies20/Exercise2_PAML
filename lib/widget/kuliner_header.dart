import 'package:flutter/material.dart';

class KulinerHeader extends StatelessWidget {
  const KulinerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text("Data Kuliner"),
      ),
    );
  }
}
