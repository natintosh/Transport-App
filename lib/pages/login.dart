import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:transport_app/utils/secure_storage.dart';
import 'package:transport_app/utils/url_helper.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(1.3, 1.3),
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Theme.of(context).accentColor,
                        Colors.white
                      ])),
            ),
          ),
          _LoginContent()
        ],
      )),
    );
  }
}

class _LoginContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginContentState();
  }
}

class _LoginContentState extends State<_LoginContent> {
  bool isSignInToggle = true;
  static final String signInText = "SIGN IN";
  static final String registerText = "REGISTER";
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    _automaticSignIn();
    super.initState();
  }

  Future _automaticSignIn() async {
    String token = await storage.read(key: 'token');

    if (token != null) {
      Navigator.of(context).pushReplacementNamed("/index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getButtonTab(_LoginContentState.signInText, isSignInToggle),
                  SizedBox(width: 16.0),
                  getButtonTab(registerText, !isSignInToggle)
                ],
              ),
            ),
            SizedBox(
              child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: getCurrentForm(isSignInToggle),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getCurrentForm(bool isToggled) {
    return (isToggled) ? _SignInFormWidget() : _RegisterFormWidget();
  }

  Widget getButtonTab(String title, bool isToggled) {
    Widget raisedButton = RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      textColor: Colors.white,
      color: Theme.of(context).primaryColorDark,
      onPressed: () {
        if (!isToggled) {
          toggleContent();
        }
      },
      child: Text(title),
    );
    Widget flatButton = FlatButton(
        onPressed: () {
          if (!isToggled) {
            toggleContent();
          }
        },
        child: Text(title));

    return (isToggled) ? raisedButton : flatButton;
  }

  toggleContent() {
    setState(() {
      isSignInToggle = !isSignInToggle;
    });
  }

  showSnackBar() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Tap'),
    ));
  }
}

class _SignInFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInFormWidgetState();
  }
}

class _SignInFormWidgetState extends State<_SignInFormWidget> {
  final _signInContentKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isButtonActive = true;

  void _setButtonState() {
    setState(() {
      _isButtonActive = !_isButtonActive;
    });
  }

  Future<Null> signInUser(
      {@required String username, @required String password}) async {
    _setButtonState();
    String url = BaseURL + LoginEndPoint;
    var response = await http
        .post(url, body: {'username': '$username', 'password': '$password'});

    if (response.statusCode == 200) {
      Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Successfully Sign In'),
      ));
      var jsonResponse = convert.jsonDecode(response.body);
      SecureStorage.writeValueToKey(key: 'token', value: jsonResponse['key']);
      Navigator.of(context).pushReplacementNamed("/index");
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 60),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Failed to Sign In'),
              FlatButton(
                  onPressed: () {
                    Scaffold.of(context).hideCurrentSnackBar();
                  },
                  child: Text('close'))
            ],
          )));
      _setButtonState();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInContentKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(4),
              child: Card(
                  elevation: 8,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 20.0),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Username", border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Username';
                        }
                      },
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.all(4),
              child: Card(
                  elevation: 8,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _passwordController,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Password", border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Passwords';
                        }
                      },
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              height: 48,
              width: double.infinity,
              child: RaisedButton(
                onPressed: _isButtonActive ? _validateAndSignIn : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                textColor: Colors.white,
                color: Theme.of(context).primaryColorDark,
                child: Text(_LoginContentState.signInText),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _validateAndSignIn() {
    if (_signInContentKey.currentState.validate()) {
      signInUser(
          username: _usernameController.text,
          password: _passwordController.text);
    }
  }
}

class _RegisterFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterFormWidgetState();
  }
}

class _RegisterFormWidgetState extends State<_RegisterFormWidget> {
  final _registerContentKey = GlobalKey<FormState>();
  final String emailRegExp =
      "^([a-z0-9,!#\\\$%&'\\*\\+/=\\?\\^_`\\{\\|}~-]+(\\.[a-z0-9,!#\\\$%&'\\*\\+/=\\?\\^_`\\{\\|}~-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*\\.([a-z]{2,})){1}(;[a-z0-9,!#\\\$%&'\\*\\+/=\\?\\^_`\\{\\|}~-]+(\\.[a-z0-9,!#\\\$%&'\\*\\+/=\\?\\^_`\\{\\|}~-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*\\.([a-z]{2,}))*\$";

  RegExp _regExp;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _regExp = RegExp(emailRegExp);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerContentKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(4),
              child: Card(
                  elevation: 8,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20.0),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Username", border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Username';
                        }
                        if (value.length < 4) {
                          return 'Enter a username greater than 4 letters';
                        }
                      },
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.all(4),
              child: Card(
                  elevation: 8,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 20.0),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Email", border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        if (!_regExp.hasMatch(value)) {
                          return 'Incorrect Email';
                        }
                      },
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.all(4),
              child: Card(
                  elevation: 8,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _passwordController,
                      style: TextStyle(fontSize: 20.0),
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Password", border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Passwords';
                        }
                      },
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              height: 48,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  if (_registerContentKey.currentState.validate()) {
                    Navigator.of(context).pushReplacementNamed("/index");
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                textColor: Colors.white,
                color: Theme.of(context).primaryColorDark,
                child: Text(_LoginContentState.registerText),
              ),
            ),
          )
        ],
      ),
    );
  }
}
