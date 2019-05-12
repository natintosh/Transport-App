import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _HomeContent();
  }
}

class _HomeContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeContentState();
  }
}

class _HomeContentState extends State<_HomeContent> {
  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: viewportConstraints.maxHeight),
            child: Container(
              height: double.infinity,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 25, bottom: 25),
                      child: Center(
                          child: SearchBarWidget(
                        onTap: openSearchPage,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25, bottom: 25),
                      child: DetailsCardWidget(
                        onTap: openTravelDetailsPage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void openSearchPage() {
    Navigator.of(context).pushNamed('/search');
  }

  void openTravelDetailsPage() {
    Navigator.of(context).pushNamed('/travel-details');
  }
}

showSnackBar({@required BuildContext context, String s = 'tap'}) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(s),
  ));
}

class SearchBarWidget extends StatefulWidget {
  final VoidCallback onTap;

  SearchBarWidget({@required this.onTap});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarWidgetState();
  }
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: 'searchCardHero',
        child: Material(
          child: Card(
              shape: StadiumBorder(),
              elevation: 8,
              margin: EdgeInsets.all(8),
              child: InkWell(
                onTap: widget.onTap,
                customBorder: StadiumBorder(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          style: TextStyle(fontSize: 20.0),
                          textInputAction: TextInputAction.search,
                          enabled: false,
                          decoration: InputDecoration(
                              hintText: "Search Destination", border: InputBorder.none),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () {
                            showSnackBar(context: context, s: 'Open Profile');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

class DetailsCardWidget extends StatefulWidget {
  final VoidCallback onTap;

  DetailsCardWidget({@required this.onTap});

  @override
  State<StatefulWidget> createState() {
    return _DetailsCardWidgetState();
  }
}

class _DetailsCardWidgetState extends State<DetailsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 8,
      margin: EdgeInsets.all(8),
      color: Colors.yellowAccent,
      child: InkWell(
        onTap: widget.onTap,
        child: cardContent(),
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  Widget cardContent() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[destinationRow(), detailsRow(), busDetails()],
      ),
    );
  }

  Widget busDetails() {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Transport",
            style: TextStyle(fontSize: 14),
          ),
          Text(
            "MNT",
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }

  Widget detailsRow() {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DetailsTextWidget("Depart", "17:00"),
          DetailsTextWidget("Arrive", "02:00"),
          DetailsTextWidget("Terminal", "03"),
          DetailsTextWidget("Quantity", "1")
        ],
      ),
    );
  }

  Widget destinationRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: DetailsTextWidget(
            "Lagos",
            "LAG",
            headerFontSize: 20,
            contentFontSize: 40,
          ),
        ),
        Expanded(
          child: Container(
            child: Icon(
              Icons.arrow_forward,
              size: 40,
            ),
          ),
        ),
        Expanded(
          child: DetailsTextWidget(
            "Kaduna",
            "KAD",
            headerFontSize: 20,
            contentFontSize: 40,
          ),
        )
      ],
    );
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
