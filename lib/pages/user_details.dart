import 'package:flutter/material.dart';
import 'package:transport_app/models/user_model.dart';

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
            title: Text('Username'),
            subtitle: Text('${userInstance.user.username ?? ''}'),
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text('${userInstance.user.email ?? ''}'),
          ),
          ListTile(
            title: Text('First Name'),
            subtitle: Text('${userInstance.user.firstName ?? ''}'),
          ),
          ListTile(
            title: Text('Last Name'),
            subtitle: Text('${userInstance.user.lastName ?? ''}'),
          ),
          ListTile(
            title: Text('Date of Birth'),
            subtitle: Text('${userInstance.user.dateOfBirth ?? ''}'),
          ),
          ListTile(
            title: Text('Address'),
            subtitle: Text('${userInstance.user.address ?? ''}'),
          ),
          ListTile(
            title: Text('Phone Number'),
            subtitle: Text('${userInstance.user.phoneNumber ?? ''}'),
          ),
          ListTile(
            title: Text('Next of Kin'),
            subtitle: Text('${userInstance.user.nextOfKin ?? ''}'),
          ),
          ListTile(
            title: Text("Next of Kin's Phone Number"),
            subtitle: Text('${userInstance.user.nextOfKinPhoneNumber ?? ''}'),
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
