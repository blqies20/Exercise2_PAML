import 'package:exercise2/widget/kuliner_form.dart';
import 'package:exercise2/widget/kuliner_header.dart';
import 'package:flutter/material.dart';

class InputView extends StatefulWidget {
  const InputView({super.key});

  @override
  State<InputView> createState() => _InputViewState();
}

class _InputViewState extends State<InputView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [KulinerHeader(), FormKuliner()],),
    );
  }
}