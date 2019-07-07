import 'package:flutter/material.dart';
import 'package:uimage/image_process.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UImage',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ImageProccess(),
    );
  }
}
