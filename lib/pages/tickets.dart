import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavouritePageContent(),
    );
  }
}

class FavouritePageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavouritePageContentState();
  }
}

class FavouritePageContentState extends State<FavouritePageContent> {
  int currentPage = 0;
  PageController controller = PageController(initialPage: 0);

  void setCurrentPage(int index) {
    setState(() {
      currentPage = index;
      controller.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: controller,
          itemCount: 2,
          onPageChanged: setCurrentPage,
          itemBuilder: (context, index) {
            return index == 0 ? ActivePage() : ExpiredPage();
          },
        ),
        Align(
          alignment: Alignment(0, -1),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getPageButton(currentPage, 0, name: "Active"),
                getPageButton(currentPage, 1, name: "Expired"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getPageButton(int index, int i, {@required String name}) {
    Widget activeButton = RawMaterialButton(
      fillColor: Colors.green,
      onPressed: () {},
      splashColor: Colors.green.shade600,
      child: Text(
        "$name",
        style: TextStyle(color: Colors.white),
      ),
    );
    Widget expiredButton = OutlineButton(
      onPressed: () {
        setCurrentPage(i);
      },
      borderSide: BorderSide(color: Colors.grey),
      child: Text(
        "$name",
        style: TextStyle(color: Colors.grey),
      ),
    );
    return index == i ? activeButton : expiredButton;
  }
}

class ActivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          Widget item = index == 0
              ? SizedBox(
                  height: 52,
                )
              : Container(
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
                                DetailsTextWidget("Departing", "04:00 AM"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
          return item;
        });
  }
}

class ExpiredPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          Widget item = index == 0
              ? SizedBox(
                  height: 52,
                )
              : Container(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Origin",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .merge(TextStyle(fontSize: 18)),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Lagos",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .merge(TextStyle(fontSize: 18)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Destination",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .merge(TextStyle(fontSize: 18)),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
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
                            padding: EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Quanity",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .merge(TextStyle(fontSize: 18)),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "${1}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle
                                      .merge(TextStyle(fontSize: 18)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
          return item;
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
