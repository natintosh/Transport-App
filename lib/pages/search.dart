import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _SearchContent()),
    );
  }
}

class _SearchContent extends StatefulWidget {
  List<String> _getDestination() {
    List<String> destination = [
      "Lagos",
      "Abuja",
      "Enugu",
      "Ibadan",
      "Imo",
      "Benin",
      "Calabar",
      "Ogun",
      "Delta",
      "Edo",
    ];

    return destination;
  }

  @override
  State<StatefulWidget> createState() {
    return _SearchContentState();
  }
}

class _SearchContentState extends State<_SearchContent> {
  String _destinationValue;
  String _originValue;

  void _setDestinationValue(String value) {
    setState(() {
      _destinationValue = value;
    });
  }

  void _setOriginValue(String value) {
    setState(() {
      _originValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CloseButton(),
            Expanded(
              child: Hero(
                tag: 'searchCardHero',
                child: Material(
                  child: Card(
                    elevation: 8,
                    margin: EdgeInsets.all(8),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DropdownButton<String>(
                              items: widget
                                  ._getDestination()
                                  .map((destination) =>
                                      DropdownMenuItem<String>(
                                          value: destination,
                                          child: Text(destination)))
                                  .toList(),
                              value: _originValue,
                              onChanged: _setOriginValue),
                          Icon(Icons.directions_bus),
                          DropdownButton<String>(
                              items: widget
                                  ._getDestination()
                                  .map((destination) =>
                                      DropdownMenuItem<String>(
                                          value: destination,
                                          child: Text(destination)))
                                  .toList(),
                              value: _destinationValue,
                              onChanged: _setDestinationValue),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                            tooltip: 'Search',
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: buildSearchResultList(),
        )
      ],
    );
  }

  Widget buildSearchResultList() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile();
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: 10);
  }
}
