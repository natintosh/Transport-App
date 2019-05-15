import 'package:flutter/material.dart';

class TransportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransportPageContent();
  }
}

class TransportPageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransportPageContentState();
  }
}

class _TransportPageContentState extends State<TransportPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, bodyIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    title: Text("MNT Transport",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
              )
            ];
          },
          body: Container(
            child: Column(
              children: <Widget>[
                _TransportDetailsCard(
                    details:
                        "Best Transport in Africa, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut vestibulum eros, vel elementum nisi. Donec dolor magna, euismod sit amet mi et, rhoncus vulputate lectus. Curabitur placerat condimentum mi."),
                _TransportDestinationCard(destination: <String>[]),
                _TransportBookTicket(),
              ],
            ),
          )),
    );
  }
}

class _TransportDetailsCard extends StatelessWidget {
  final String details;
  _TransportDetailsCard({@required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Details",
                style: TextStyle(fontSize: 18.0),
              ),
              Divider(),
              Text(details)
            ],
          ),
        ),
      ),
    );
  }
}

class _TransportDestinationCard extends StatelessWidget {
  final List<String> destination;
  _TransportDestinationCard({@required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Destinations",
                style: TextStyle(fontSize: 18.0),
              ),
              Divider(),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 10.0,
                children: <Widget>[
                  Chip(label: Text("Lagos")),
                  Chip(label: Text("Enugu")),
                  Chip(label: Text("Kaduna")),
                  Chip(label: Text("Abuja")),
                  Chip(label: Text("Ibadan")),
                  Chip(label: Text("Benin")),
                  Chip(label: Text("Calabar")),
                  Chip(label: Text("Ogun")),
                  Chip(label: Text("Delta")),
                  Chip(label: Text("Edo")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransportBookTicket extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransportBookTicketState();
  }
}

class _TransportBookTicketState extends State<_TransportBookTicket> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Book Ticket",
                style: TextStyle(fontSize: 18.0),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
