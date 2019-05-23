import 'package:flutter/material.dart';
import 'package:transport_app/pages/tickets.dart';
import 'package:transport_app/pages/home.dart';
import 'package:transport_app/pages/terminals.dart';

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
                      colors: <Color>[Theme.of(context).accentColor, Colors.white])),
            ),
          ),
          tabItems[currentIndex]
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus), title: Text("Terminal")),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_play), title: Text("Favourites")),
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
