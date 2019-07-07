import 'package:flutter/material.dart';
import 'package:persistencia_de_dados_flutter/ui/HomePage.dart';


void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget build(BuildContext context){
      return MaterialApp(
        title: 'SQLite Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      );
    }
  }
}
