import 'package:flutter/material.dart';
import 'package:transport_app/pages/bus_details.dart';
import 'package:transport_app/pages/details.dart';
import 'package:transport_app/pages/profile.dart';
import 'package:transport_app/pages/search.dart';
import 'package:transport_app/pages/login.dart';
import 'package:transport_app/pages/index.dart';
import 'package:transport_app/pages/transport.dart';

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
        "/transport": (BuildContext context) => TransportPage(),
        "/bus-details": (BuildContext context) => BusDetailsPage(),
        "/profile": (BuildContext context) => ProfilePage(),
      },
      title: "Transhub",
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.yellowAccent),
    );
  }
}
