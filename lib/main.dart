import 'package:flutter/material.dart';
import 'package:transport_app/pages/about.dart';
import 'package:transport_app/pages/bus_details.dart';
import 'package:transport_app/pages/feedback.dart';
import 'package:transport_app/pages/preferences.dart';
import 'package:transport_app/pages/ticket_details.dart';
import 'package:transport_app/pages/profile.dart';
import 'package:transport_app/pages/search.dart';
import 'package:transport_app/pages/login.dart';
import 'package:transport_app/pages/index.dart';
import 'package:transport_app/pages/transport.dart';
import 'package:transport_app/pages/trip_details.dart';
import 'package:transport_app/pages/user_details.dart';

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
        "/travel-details": (BuildContext context) => TicketDetailsPage(),
        "/transport": (BuildContext context) => TransportPage(),
        "/bus-details": (BuildContext context) => BusDetailsPage(),
        "/profile": (BuildContext context) => ProfilePage(),
        "/about": (BuildContext context) => AboutPage(),
        "/feedback": (BuildContext context) => FeedbackPage(),
        "/preferences": (BuildContext context) => PreferencePage(),
        "/trip-details": (BuildContext context) => MyTripDetailsPage(),
        "/user-details": (BuildContext context) => UserDetailsPage(),
      },
      title: "Transhub",
      theme: ThemeData(
          primarySwatch: Colors.green, accentColor: Colors.yellowAccent),
    );
  }
}
