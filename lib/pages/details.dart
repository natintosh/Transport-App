import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetailsPageState();
  }
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavourite = false;

  _setFavourite() {
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
              icon: isFavourite
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(Icons.favorite_border),
              tooltip: "Favorite",
              onPressed: _setFavourite)
        ],
      ),
      backgroundColor: Colors.green[200],
      body: SafeArea(child: DetailsPageContent()),
    );
  }
}

class DetailsPageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetailPageContentState();
  }
}

class _DetailPageContentState extends State<DetailsPageContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: _DestinationCardWidget(),
        )),
        _DestinationContentGirdViewWidget(content: getMappedItem()),
      ],
    );
  }

  Map<String, String> getMappedItem() {
    Map<String, String> map = Map();
    map.putIfAbsent("Depart", () => "17:00");
    map.putIfAbsent("Arrive", () => "02:00");
    map.putIfAbsent("Terminal", () => "03");
    map.putIfAbsent("Quantity", () => "1");
    return map;
  }
}

class _DestinationContentGirdViewWidget extends StatelessWidget {
  final Map<String, String> content;

  _DestinationContentGirdViewWidget({@required this.content});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 4 / 3,
      children: getChildrenWidget(content),
    );
  }

  List<Widget> getChildrenWidget(Map<String, String> content) {
    List<Widget> children = List();
    content.forEach((key, value) {
      children.add(Center(
        child: _DetailsTextWidget(header: key, content: value),
      ));
    });

    return children;
  }
}

class _DetailsTextWidget extends StatelessWidget {
  final String header;
  final String content;
  final double headerFontSize;
  final double contentFontSize;
  final FontWeight contentFontWeight;

  _DetailsTextWidget(
      {@required this.header,
      @required this.content,
      this.headerFontSize = 20,
      this.contentFontSize = 40,
      this.contentFontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

class _DestinationCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: _LocationTileWidget(
              status: LocationStatus.from,
              direction: "From",
              place: "Lagos, LAG",
            ),
          ),
          Divider(),
          Container(
            child: _LocationTileWidget(
              status: LocationStatus.to,
              direction: "To",
              place: "Kaduna, KAD",
            ),
          )
        ],
      ),
    );
  }
}

enum LocationStatus { from, inBetween, to }

class _LocationTileWidget extends StatelessWidget {
  final LocationStatus status;
  final String direction;
  final String place;

  _LocationTileWidget(
      {@required this.status, @required this.direction, @required this.place});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 60,
            height: 60,
            child: getStatusWidget(status),
          ),
        ),
        Expanded(
          flex: 8,
          child: _LocationTextWidget(direction: direction, place: place),
        ),
      ],
    );
  }

  Widget getStatusWidget(LocationStatus status) {
    return ((status == LocationStatus.from
        ? _LocationStatusFromWidget()
        : (status == LocationStatus.inBetween
            ? _LocationStatusInBetweenWidget()
            : _LocationStatusToWidget())));
  }
}

class _LocationStatusFromWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _CircularDotWidget(
          color: Colors.green,
          padding: 4,
        ),
        _CircularDotWidget(color: Colors.grey),
        _CircularDotWidget(color: Colors.grey)
      ],
    );
  }
}

class _LocationStatusToWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _CircularDotWidget(color: Colors.grey),
        _CircularDotWidget(color: Colors.grey),
        _CircularDotWidget(
          color: Colors.green,
          padding: 4,
        )
      ],
    );
  }
}

class _LocationStatusInBetweenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _CircularDotWidget(color: Colors.grey),
        _CircularDotWidget(color: Colors.grey),
        _CircularDotWidget(color: Colors.grey)
      ],
    );
  }
}

class _CircularDotWidget extends StatelessWidget {
  final double padding;
  final Color color;
  _CircularDotWidget({@required this.color, this.padding = 2});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Padding(padding: EdgeInsets.all(padding)),
    );
  }
}

class _LocationTextWidget extends StatelessWidget {
  final String direction;
  final String place;

  _LocationTextWidget({@required this.direction, @required this.place});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(direction),
        Text(place, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
      ],
    );
  }
}
