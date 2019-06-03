import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:transport_app/models/user_model.dart';
import 'package:transport_app/pages/home.dart';
import 'package:transport_app/pages/terminals.dart';
import 'package:transport_app/pages/tickets.dart';
import 'package:transport_app/utils/url_helper.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(child: _IndexContent()),
    );
  }
}

class _IndexContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexContentState();
  }
}

class _IndexContentState extends State<_IndexContent> {
  var currentIndex = 0;
  final List<Widget> tabItems = [HomePage(), TerminalPage(), TicketPage()];
  bool _inactive = true;

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    _initialSetUp();
    super.initState();
  }

  Future _initialSetUp() async {
    String url = BaseURL + UserEndPoint;
    String authToken = 'Token ${await storage.read(key: 'token')}';

    var client = http.Client();
    try {
      var userResponse =
          await client.get(url, headers: {'Authorization': authToken});
      if (userResponse.statusCode == HttpStatus.ok) {
        var userData = jsonDecode(userResponse.body);
        userInstance.user = User(
          id: userData['pk'],
          username: userData['username'],
          email: userData['email'],
          firstName: userData['first_name'],
          lastName: userData['last_name'],
        );
      }
    } finally {
      print(userInstance.user.username);
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(1.3, 1.3),
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Theme.of(context).accentColor,
                        Colors.white
                      ])),
            ),
          ),
          tabItems[currentIndex]
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus), title: Text("Terminals")),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_play), title: Text("History")),
        ],
      ),
    );
  }

  showSnackBar() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Tap'),
    ));
  }
}
