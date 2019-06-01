import 'package:flutter/material.dart';

class UserDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _UserDetailsContent(),
    );
  }
}

class _UserDetailsContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserDetailsContentState();
  }
}

class _UserDetailsContentState extends State<_UserDetailsContent> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            expandedHeight: screenSize.width * 0.8,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: _ProfilePictureWidget(),
            )),
        SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          ListTile(
            title: Text('First Name'),
            subtitle: Text('John'),
          ),
          ListTile(
            title: Text('Last Name'),
            subtitle: Text('Doe'),
          ),
          ListTile(
            title: Text('Date of Birth'),
            subtitle: Text('Tuesday, 29th May 1959'),
          ),
          ListTile(
            title: Text('Address'),
            subtitle: Text('1180, Elton John'),
          ),
          ListTile(
            title: Text('Phone Number'),
            subtitle: Text('08121002001'),
          ),
          ListTile(
            title: Text('Next of Kin'),
            subtitle: Text('Emilia Doe'),
          ),
          ListTile(
            title: Text('Next of Kin Phone Number'),
            subtitle: Text('08121002001'),
          ),
        ]))
      ],
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
