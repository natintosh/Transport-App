import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:transport_app/utils/url_helper.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ProfilePageContent(),
    );
  }
}

class _ProfilePageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageContentState();
  }
}

enum ProfileMenu { Details, Preferences, MyTripDetails, SendFeedback, About }

class _ProfilePageContentState extends State<_ProfilePageContent> {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            centerTitle: true,
            title: Text("John Doe"),
            expandedHeight: screenSize.width * 0.8,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: _ProfilePictureWidget(),
            )),
        SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          _ProfileListItemWidget(
            title: "Details",
            routeName: '/user-details',
          ),
          _ProfileListItemWidget(title: "Preferences"),
          _ProfileListItemWidget(
              title: "My Trip Details", routeName: "/trip-details"),
          _ProfileListItemWidget(
            title: "Send Feedback",
            routeName: "/feedback",
          ),
          _ProfileListItemWidget(
            title: "About",
            routeName: "/about",
          ),
          _ProfileListItemWidget(
            title: "sign Out",
            routeName: null,
            callback: _signOut,
          ),
        ]))
      ],
    );
  }

  Future _signOut() async {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Successfully sign out')));

    String url = BaseURL + LogoutEndPoint;
    String authToken = 'Token ${await storage.read(key: 'token')}';

    var response = await http.post(url, headers: {'Authorization': authToken});

    if (response.statusCode == 200) {
      await storage.delete(key: 'token');
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }
}

class _ProfileListItemWidget extends StatelessWidget {
  final String title;
  final String routeName;
  final VoidCallback callback;
  const _ProfileListItemWidget(
      {@required this.title, this.routeName, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      child: InkWell(
        onTap: () {
          if (routeName != null) {
            Navigator.of(context).pushNamed(routeName);
          } else {
            callback();
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Align(
            alignment: Alignment(-1, 0),
            child: Text(
              "$title",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfilePictureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Stack(alignment: Alignment(0, 0), children: <Widget>[
      ClipPath(
        clipper: BottomWaveClipper(),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
      CircleAvatar(
        backgroundImage: AssetImage('assets/images/ic_profile.png'),
        maxRadius: screenSize.width * 0.25,
        backgroundColor: Colors.grey,
      )
    ]);
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * 0.75);

    var arcEndOffset = Offset(size.width, size.height * 0.75);
    path.arcToPoint(arcEndOffset,
        radius: Radius.circular(size.height), clockwise: false);

    path.lineTo(size.width, 0.00);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
