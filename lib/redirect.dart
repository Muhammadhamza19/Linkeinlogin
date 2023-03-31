import 'package:flutter/material.dart';

class Redirect extends StatelessWidget {
  const Redirect({super.key});
  static const String route = '/redirect';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: Container(
          child: Text('Hi'),
        ),
      ),
    );
  }
}
