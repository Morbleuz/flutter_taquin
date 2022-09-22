import 'package:flutter/material.dart';
import 'package:flutter_taquin/taquin.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'homepage.dart';

Future<void> main() async {
  //init du hive
  await Hive.initFlutter();
  //open de la box
  var box = await Hive.openBox('taquin');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taquin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}
