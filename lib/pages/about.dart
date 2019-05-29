import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("About"),),
        body: SingleChildScrollView(
          child: Text(lorem(paragraphs: 8, words: 2000), style: Theme.of(context).textTheme.body1,),
        ),
      ),
    );
  }
}