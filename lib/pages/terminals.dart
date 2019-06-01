import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:transport_app/models/company.dart';
import 'package:transport_app/pages/transport.dart';
import 'package:transport_app/utils/url_helper.dart';

class TerminalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TerminalPageContent();
  }
}

class TerminalPageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TerminalPageContentState();
  }
}

class _TerminalPageContentState extends State<TerminalPageContent> {
  final storage = FlutterSecureStorage();
  static List<Company> companiesObject;

  @override
  void initState() {
    loadCompanyAsset();
    super.initState();
  }

  Future loadCompanyAsset() async {
    String url = BaseURL + TransportEndPoint;
    String authToken = 'Token ${await storage.read(key: 'token')}';

    var response = await http.get(url, headers: {'Authorization': authToken});

    if (response.statusCode == 200) {
      List<Company> mapped = (jsonDecode(response.body) as List)
          .asMap()
          .map((index, company) => MapEntry(
              index,
              Company(
                  id: index + 1,
                  name: "${company['name']}",
                  description: "${company["description"]}",
                  imageUrl: "$BaseURL${company["transportation_line_logo"]}")))
          .values
          .toList();

      if (this.mounted) {
        setState(() {
          companiesObject = mapped;
        });
      }
    }
  }

  void openTransportPage(int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TransportPage(
            company: companiesObject[index], tag: "companyLogo-$index")));
  }

  @override
  Widget build(BuildContext context) {
    return (companiesObject == null)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          )
        : ListView.builder(
            itemCount: companiesObject != null ? companiesObject.length : 0,
            itemBuilder: (context, index) {
              String companyName = "${companiesObject[index].name}";
              String imageUrl = "${companiesObject[index].imageUrl}";
              String description = "${companiesObject[index].description}";

              return _TransportCardWidget(
                id: index,
                name: companyName,
                imageUrl: imageUrl,
                about: description,
                onTap: () => openTransportPage(index),
              );
            });
  }
}

class _TransportCardWidget extends StatefulWidget {
  final int id;
  final String name;
  final String imageUrl;
  final String about;
  final VoidCallback onTap;

  _TransportCardWidget(
      {@required this.id,
      @required this.name,
      @required this.imageUrl,
      @required this.about,
      @required this.onTap});

  @override
  State<StatefulWidget> createState() {
    return _TransportCardWidgetState();
  }
}

class _TransportCardWidgetState extends State<_TransportCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        child: InkWell(
          onTap: widget.onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Material(
                  child: Hero(
                      tag: "companyLogo-${widget.id}",
                      child: _TransportLogoImageWidget(
                        source: widget.imageUrl,
                      )),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: _TransportLabelTextWidget(
                      name: widget.name, about: widget.about),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TransportLogoImageWidget extends StatelessWidget {
  final String source;

  _TransportLogoImageWidget({@required this.source});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Image.network(
        source,
      ),
    );
  }
}

class _TransportLabelTextWidget extends StatelessWidget {
  final String name;
  final String about;

  _TransportLabelTextWidget({@required this.name, @required this.about});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(about,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
