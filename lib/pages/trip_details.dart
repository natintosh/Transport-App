import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:transport_app/models/user_model.dart';
import 'package:transport_app/utils/url_helper.dart';

class MyTripDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Details'),
      ),
      body: _MyTripDetailsContent(),
    );
  }
}

class _MyTripDetailsContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTripDetailsContentState();
  }
}

class _MyTripDetailsContentState extends State<_MyTripDetailsContent> {
  final storage = FlutterSecureStorage();

  DateTime dateOfBirth = DateTime.now();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nextOfKinController = TextEditingController();
  TextEditingController _nextOfKinPhoneNumberController =
      TextEditingController();

  File _image;

  bool _isButtonEnabled = true;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void _setDateOfBirth(DateTime date) {
    setState(() {
      dateOfBirth = date;
    });
  }

  void _setButton() {
    setState(() {
      _isButtonEnabled = !_isButtonEnabled;
    });
  }

  @override
  void initState() {
    _firstNameController.text = '${userInstance.user.firstName ?? ''}';
    _lastNameController.text = '${userInstance.user.lastName ?? ''}';
    _phoneNumberController.text = '${userInstance.user.phoneNumber ?? ''}';
    _addressController.text = '${userInstance.user.address ?? ''}';
    _nextOfKinController.text = '${userInstance.user.nextOfKin ?? ''}';
    _nextOfKinPhoneNumberController.text =
        '${userInstance.user.nextOfKinPhoneNumber ?? ''}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: (_image == null)
                        ? AssetImage('assets/images/ic_profile.png')
                        : FileImage(_image),
                    maxRadius: 72,
                    backgroundColor: Colors.grey,
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Tooltip(
                      message: 'Edit Profile Picture',
                      child: FlatButton(
                        shape: CircleBorder(),
                        color: Colors.yellowAccent,
                        onPressed: getImage,
                        child: SizedBox(
                            width: 48,
                            height: 48,
                            child: Icon(Icons.add_photo_alternate)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _DetailTextFieldWidget(
              title: 'First Name',
              controller: _firstNameController,
            ),
            _DetailTextFieldWidget(
              key: UniqueKey(),
              title: 'Last Name',
              controller: _lastNameController,
            ),
            _DetailCalenderWidget(
                title: 'Date of Birth',
                date: dateOfBirth,
                onDateChanged: _setDateOfBirth),
            _DetailTextFieldWidget(
              title: 'Phone Number',
              controller: _phoneNumberController,
              textInputType: TextInputType.phone,
            ),
            _DetailTextFieldWidget(
              title: 'Address',
              controller: _addressController,
            ),
            _DetailTextFieldWidget(
              title: 'Next of Kin',
              controller: _nextOfKinController,
            ),
            _DetailTextFieldWidget(
              title: 'Next of Kin Phone Number',
              controller: _nextOfKinPhoneNumberController,
              textInputType: TextInputType.phone,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 9),
              child: SizedBox(
                height: 42,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: !_isButtonEnabled
                      ? null
                      : () {
                          _updateUserDetails();
                        },
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text('SUBMIT'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _updateUserDetails() async {
    _setButton();

    String url = BaseURL + UserEndPoint;
    String authToken = 'Token ${await storage.read(key: 'token')}';

    var client = http.Client();
    try {
      var userResponse = await client.patch(url, headers: {
        'Authorization': authToken
      }, body: {
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text
      });
      if (userResponse.statusCode == HttpStatus.ok) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/index', (router) => false);
      }
    } finally {
      print(userInstance.user.username);
      client.close();
    }
  }
}

class _DetailTextFieldWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType textInputType;
  const _DetailTextFieldWidget(
      {Key key,
      @required this.title,
      @required this.controller,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailTextFieldWidgetState();
  }
}

class _DetailTextFieldWidgetState extends State<_DetailTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.title}',
              style: Theme.of(context).textTheme.body1,
            ),
            TextField(
              controller: widget.controller,
              keyboardType: widget.textInputType,
            )
          ]),
    );
  }
}

class _DetailCalenderWidget extends StatefulWidget {
  final String title;
  final ValueChanged<DateTime> onDateChanged;
  final DateTime date;

  const _DetailCalenderWidget(
      {Key key,
      @required this.title,
      @required this.onDateChanged,
      @required this.date})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailCalenderWidgetState();
  }
}

class _DetailCalenderWidgetState extends State<_DetailCalenderWidget> {
  void _setSelectedDate(DateTime date) {
    setState(() {
      widget.onDateChanged(date);
    });
  }

  String getFormattedDate(DateTime date) {
    DateFormat formatter = DateFormat('EEEE, d  MMMM y');
    String format = formatter.format(date);
    return format;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.date,
        firstDate: DateTime(1900),
        lastDate: DateTime(2120));

    if (pickedDate != null) {
      _setSelectedDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.title),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(getFormattedDate(widget.date)),
                IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () => _selectDate(context))
              ],
            )
          ]),
    );
  }
}
