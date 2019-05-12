import 'package:flutter/material.dart';
import 'package:transport_app/pages/details.dart';
import 'package:transport_app/pages/search.dart';
import 'package:transport_app/pages/login.dart';
import 'package:transport_app/pages/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => LoginPage(),
        "/index": (BuildContext context) => IndexPage(),
        "/search": (BuildContext context) => SearchPage(),
        "/travel-details": (BuildContext context) => DetailsPage(),
      },
      title: "Transhub",
      theme: ThemeData(
          primaryColor: Colors.green, accentColor: Colors.yellowAccent),
    );
  }
}
