import 'package:flutter/material.dart';

class BusDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bus Details")),
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
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Lagos",
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .merge(TextStyle(fontSize: 18)),
                          ),
                          Icon(Icons.directions_bus),
                          Text(
                            "Kaduna",
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .merge(TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DetailsTextWidget("Quantity", "${1}"),
                          DetailsTextWidget("Seats Avaliable", "${12}"),
                          DetailsTextWidget("Price", "N6,580")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DetailsTextWidget("Departing", "04:00 AM"),
                          RaisedButton(
                            onPressed: () {},
                            color: Theme.of(context).accentColor,
                            child: Text("Book"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class DetailsTextWidget extends StatelessWidget {
  final String header;
  final String content;
  final double headerFontSize;
  final double contentFontSize;
  final FontWeight contentFontWeight;

  DetailsTextWidget(this.header, this.content,
      {this.headerFontSize = 12,
      this.contentFontSize = 20,
      this.contentFontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          header,
          style: TextStyle(fontSize: headerFontSize),
        ),
        Text(
          content,
          style: TextStyle(
              fontSize: contentFontSize, fontWeight: contentFontWeight),
        )
      ],
    );
  }
}
