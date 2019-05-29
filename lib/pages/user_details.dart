import 'package:flutter/material.dart';

class UserDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: _UserDetailsContent(),
    );
  }
}

class _UserDetailsContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserDetailsContentState();
  }
}

class _UserDetailsContentState extends State<_UserDetailsContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(),
    );
  }
}
