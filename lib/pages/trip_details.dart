import 'package:flutter/material.dart';

class MyTripDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Trip Details'),
      ),
      body: _MyTripDetailsContent(),
    );
  }
}

class _MyTripDetailsContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTripDetailsContentState();
  }
}

class _MyTripDetailsContentState extends State<_MyTripDetailsContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            _DetailTextFieldWidget(title: 'Name'),
            _DetailTextFieldWidget(title: 'Date of Birth'),
            _DetailTextFieldWidget(title: 'Address'),
            _DetailTextFieldWidget(title: 'Next of Kin'),
          ],
        ),
      ),
    );
  }
}

class _DetailTextFieldWidget extends StatelessWidget {
  final String title;

  const _DetailTextFieldWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$title',
              style: Theme.of(context).textTheme.body1,
            ),
            TextField()
          ]),
    );
  }
}
