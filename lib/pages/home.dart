import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:transport_app/utils/secure_storage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

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

Key ticketInfoKey = GlobalKey();

class _SearchBarWidgetState extends State<SearchBarWidget> {
  List<TargetFocus> targets = List();

  Key searchKey = GlobalKey();
  Key profileKey = GlobalKey();

  Size screenSize;

  @override
  void initState() {
    initTargets();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Hero(
              tag: 'searchCardHero',
              child: Material(
                child: Card(
                    key: searchKey,
                    shape: StadiumBorder(),
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: widget.onTap,
                      customBorder: StadiumBorder(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24.0, 2.0, 8.0, 2.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20.0),
                          textInputAction: TextInputAction.search,
                          enabled: false,
                          decoration: InputDecoration(
                              hintText: "Search", border: InputBorder.none),
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ),
        Card(
            key: profileKey,
            shape: StadiumBorder(),
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: InkWell(
              customBorder: StadiumBorder(),
              onTap: () {
                Navigator.of(context).pushNamed('/profile');
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Hero(
                        tag: 'profilePictureTag',
                        child: Material(
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/ic_profile.png'),
                            backgroundColor: Colors.grey,
                          ),
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Profile',
                        style: TextStyle(
                            fontSize: 16.0, color: Theme.of(context).hintColor))
                  ],
                ),
              ),
            ))
      ],
    );
  }

  void initTargets() {
    targets
        .add(TargetFocus(identify: 'Target 1', keyTarget: searchKey, contents: [
      ContentTarget(
          align: AlignContent.bottom,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Search",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Click here to search for avaliable ticket",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ))
    ]));
    targets.add(
        TargetFocus(identify: 'Target 2', keyTarget: profileKey, contents: [
      ContentTarget(
          align: AlignContent.bottom,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Profile",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "You can view, edit your profile and sign out from here",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ))
    ]));
    targets.add(
        TargetFocus(identify: 'Target 3', keyTarget: ticketInfoKey, contents: [
      ContentTarget(
          align: AlignContent.top,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Ticket info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Information about your recent purchased ticket would show here",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ))
    ]));
  }

  void showTutorial() {
    TutorialCoachMark(context, targets: targets, colorShadow: Colors.green,
        finish: () {
      print("finish");
      SecureStorage.writeValueToKey(key: 'hasShowTutorial', value: '1');
    }, clickSkip: () {
      print("skip");
      SecureStorage.writeValueToKey(key: 'hasShowTutorial', value: '1');
    })
      ..show();
  }

  final storage = FlutterSecureStorage();

  void _afterLayout(_) async {
    String token = await storage.read(key: 'hasShowTutorial');
    if (token != '1') {
      Future.delayed(Duration(milliseconds: 100), () {
        showTutorial();
      });
    }
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
      key: ticketInfoKey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4,
      margin: EdgeInsets.all(8),
      color: Theme.of(context).accentColor,
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
            "---",
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
          DetailsTextWidget("Depart", "--:--"),
          DetailsTextWidget("Arrive", "--:--"),
          DetailsTextWidget("Terminal", "--"),
          DetailsTextWidget("Quantity", "--")
        ],
      ),
    );
  }

  Widget destinationRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: DetailsTextWidget(
            "",
            "---",
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
            "",
            "---",
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
