import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  int counter = 0;

  @override
  initState() {
    // Start listening to stream of users from firebase
    super.initState();
  }

  @override
  void dispose() {
    // Stop listening to stream of users from firebase
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            Text(counter.toString(), style: TextStyle(fontSize: 52)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
