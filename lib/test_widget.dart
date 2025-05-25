import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The building blocks"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      )
    );
  }
}
