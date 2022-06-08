import 'package:flutter/material.dart';
import 'package:pingou_app/views/HomePage.dart';
import 'package:pingou_app/views/Encomenda.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
      },
    );
  }
}
