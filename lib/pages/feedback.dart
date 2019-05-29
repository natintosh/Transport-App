import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            TextFormField(),
            SizedBox(
              height: 16,
            ),
            Text(lorem())
          ],
        ),
      ),
    );
  }
}
