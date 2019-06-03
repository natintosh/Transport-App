import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:transport_app/models/search_model.dart';
import 'package:transport_app/utils/url_helper.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _SearchContent()),
    );
  }
}

class _SearchContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchContentState();
  }
}

class _SearchContentState extends State<_SearchContent> {
  List<SearchItem> searchResult;

  String _destinationValue;
  String _originValue;
  final storage = FlutterSecureStorage();

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
                              items: searchInstance.origins
                                  .map((destination) =>
                                      DropdownMenuItem<String>(
                                          value: destination,
                                          child: Text(destination)))
                                  .toList(),
                              value: _originValue,
                              onChanged: _setOriginValue),
                          Icon(Icons.directions_bus),
                          DropdownButton<String>(
                              items: searchInstance.destinations
                                  .map((destination) =>
                                      DropdownMenuItem<String>(
                                          value: destination,
                                          child: Text(destination)))
                                  .toList(),
                              value: _destinationValue,
                              onChanged: _setDestinationValue),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: _getSearchResult,
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
          child: Container(
            child: searchResult == null
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  )
                : buildSearchResultList(),
          ),
        )
      ],
    );
  }

  Future _getSearchResult() async {
    _setSearchResult(null);
    String url =
        BaseURL + TransportEndPoint + SearchTicketQuery + _destinationValue;
    String authToken = 'Token ${await storage.read(key: 'token')}';

    var response = await http.get(url, headers: {'Authorization': authToken});
    if (response.statusCode == HttpStatus.ok) {
      List<SearchItem> result = (jsonDecode(response.body) as List)
          .map((result) => SearchItem(
              departure: '${result['departure_state']}',
              arrival: '${result['arrival_state']}',
              date: DateTime.parse('${result['date']}'),
              price: result['price']))
          .toList();

      _setSearchResult(result);
    }
  }

  Widget buildSearchResultList() {
    return ListView.separated(
      itemCount: searchResult.length,
      separatorBuilder: (context, index) => Divider(),
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
                          "${searchResult[index].departure ?? ''}",
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .merge(TextStyle(fontSize: 18)),
                        ),
                        Icon(Icons.directions_bus),
                        Text(
                          "${searchResult[index].arrival ?? ''}",
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
                        DetailsTextWidget(
                            "Price", "N${searchResult[index].price ?? ''}")
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        DetailsTextWidget("Departing",
                            "${getFormattedDate(searchResult[index].date ?? '')}"),
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
      },
    );
  }

  String getFormattedDate(DateTime date) {
    DateFormat formatter = DateFormat('EEEE, d  MMMM y');
    String format = formatter.format(date);
    return format;
  }

  void _setSearchResult(List<SearchItem> result) {
    setState(() {
      searchResult = result;
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
