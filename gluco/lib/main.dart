// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, deprecated_member_use, unused_import, avoid_print, sized_box_for_whitespace, non_constant_identifier_names, unused_local_variable, unused_field, prefer_final_fields

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gluco/widgets/chartbox.dart';
import 'package:gluco/pages/homepage.dart';
import 'package:gluco/widgets/sidebar.dart';
import 'package:gluco/widgets/valuecard.dart';
import 'package:flutter_blue/flutter_blue.dart';
import './models/collected.dart';
import 'pages/loginpage.dart';
import 'pages/initscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: Main(),
  ));
}

class Main extends StatefulWidget {
  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  Collected _dataCollected = Collected(
    id: 0,
    batimento: 78,
    data: DateTime.now(),
    saturacao: 98,
    glicose: 98.2,
    temperatura: 36.8,
  );

  FlutterBlue bluetooth = FlutterBlue.instance;

  // desabilitar autenticação
  bool auth = true;

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      elevation: 4,
      centerTitle: true,
      // backgroundColor: Color.fromARGB(255, 98, 114, 250),
      backgroundColor: Color.fromARGB(255, 83, 100, 232),
      title: Text("E-Gluco",
          textAlign: TextAlign.center,
          style: Theme.of(context).appBarTheme.titleTextStyle),
    );

    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.green,
            // primarySwatch: Color.fromARGB(255, 98, 114, 250),
            accentColor: Colors.grey[600],
            errorColor: Colors.purple[900],
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            )),
        home: auth
            ? InitScreen(
                appBar: appBar,
                bluetooth: bluetooth,
                dataCollected: _dataCollected,
              )
            : HomePage(
                appBar: appBar,
                dataCollected: _dataCollected,
                bluetooth: bluetooth));
  }
}
