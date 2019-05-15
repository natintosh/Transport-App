import 'package:flutter/material.dart';

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
  void openTransportPage() {
    Navigator.of(context).pushNamed("/transport");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return _TransportCardWidget(
        name: "MNT",
        about: "Best transport in Africa",
        onTap: openTransportPage,
      );
    });
  }
}

class _TransportCardWidget extends StatefulWidget {
  final String name;
  final String about;
  final VoidCallback onTap;

  _TransportCardWidget(
      {@required this.name, @required this.about, @required this.onTap});

  @override
  State<StatefulWidget> createState() {
    return _TransportCardWidgetState();
  }
}

class _TransportCardWidgetState extends State<_TransportCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _TransportLogoImageWidget(),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: _TransportLabelTextWidget(
                  name: widget.name, about: widget.about),
            )
          ],
        ),
      ),
    );
  }
}

class _TransportLogoImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 7 / 3,
      child: Container(
        color: Colors.grey,
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
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Text(about,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
