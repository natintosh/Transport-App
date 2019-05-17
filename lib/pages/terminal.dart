import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:transport_app/pages/transport.dart';

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
  static Map<String, dynamic> companiesObject;

  @override
  void initState() {
    loadCompanyAsset();
    super.initState();
  }

  Future loadCompanyAsset() async {
    String jsonData = await rootBundle.loadString('assets/company.json', cache: true);
    setState(() {
      companiesObject = jsonDecode(jsonData);
    });
  }


  void openTransportPage(int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TransportPage(
            name: "${companiesObject["data"][index]["companyName"]}",
            imageUrl: "${companiesObject["data"][index]["image"]}",
            tag: "companyLogo-$index")));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: companiesObject != null ? companiesObject["data"].length : 0,
        itemBuilder: (context, index) {
          String companyName = "${companiesObject["data"][index]["companyName"]}";
          String imageUrl = "${companiesObject["data"][index]["image"]}";
          String motto = "${companiesObject["data"][index]["motto"]}";

          return _TransportCardWidget(
            id: index,
            name: companyName,
            imageUrl: imageUrl,
            about: motto,
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
