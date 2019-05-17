import 'package:flutter/material.dart';

class BusDetailsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Details")
      ),
      body: _BusDetailsPageContent(),
    );
  }
}

class _BusDetailsPageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BusDetailsPageContentSate();
  }
}

class _BusDetailsPageContentSate extends State<_BusDetailsPageContent> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}