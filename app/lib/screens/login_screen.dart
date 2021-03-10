import 'package:app/auth/auth_service.dart';
import 'package:app/screens/register_screen.dart';
import 'package:app/screens/tabs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constant.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  final _form = GlobalKey<FormState>();
  var isError = false;
  var showPass = false;
  var _showSpinner = false;
  var _loginFailed = false;
  String _errorMsg = "";

  var email = "";
  var pass = "";

  @override
  void dispose() {
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(
              width: double.infinity, height: media.size.height),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/space.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto-Medium',
                          fontSize: 34.0),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: media.size.height * 0.3,
                    child: Hero(
                        tag: 'logo', child: Image.asset("images/global.png")),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Form(
                      key: _form,
                      autovalidate: isError ? true : false,
                      child: Column(
                        children: [
                          TextFormField(
                            focusNode: _emailFocus,
                            autovalidate: isError ? true : false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_passFocus);
                            },
                            validator: (enteredText) {
                              if (enteredText.isEmpty) {
                                return "Please entered an email";
                              } else if (_loginFailed) {
                                return _errorMsg;
                              } else {
                                return null;
                              }
                            },
                            onChanged: (email) {},
                            onSaved: (val) {
                              email = val;
                            },
                            decoration: kTextFieldform.copyWith(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Enter Email",
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            focusNode: _passFocus,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            obscureText: showPass ? false : true,
                            textAlign: TextAlign.center,
                            onSaved: (val) {
                              pass = val;
                            },
                            validator: (enteredText) {
                              if (enteredText.isEmpty) {
                                return "Password cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            decoration: kTextFieldform.copyWith(
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(showPass
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded),
                                  onPressed: () {
                                    setState(() {
                                      showPass = !showPass;
                                    });
                                  },
                                ),
                                hintText: "Enter Password"),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: TextButton(
                              onPressed: _signInForm,
                              child: Text(
                                "Sign in",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Roboto-Regular",
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forget password?",
                              style: TextStyle(
                                  color: Color(0xff112BF4),
                                  fontFamily: "Roboto-Regular",
                                  fontSize: 20,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: Image.asset('images/facebook.png'),
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: Image.asset('images/google.png'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "don'\tt have account? ",
                            style: TextStyle(
                                fontFamily: 'Roboto-Regular', fontSize: 18),
                          ),
                          TextSpan(
                            text: 'Sign up',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushReplacementNamed(
                                    SignUpScreen.routeName);
                              },
                            style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                                color: Color(0xff112BF4)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signInForm() async {
    var isValid = _form.currentState.validate();
    _form.currentState.save();
    setState(() {
      _showSpinner = true;
    });
    var provider = Provider.of<AuthService>(context, listen: false);
    bool res = await provider.signIn(email: email, password: pass);

    if (!isValid) {
      setState(() {
        isError = true;
        _showSpinner = false;
      });
      if (_loginFailed) {
        setState(() {
          _loginFailed = false;
          isError = true;
          _showSpinner = true;
        });
        res = await provider.signIn(email: email, password: pass);
        print('login failed');
      }
      print('sign in button tapped inside !isValid');
    }
    if (isError) {
      setState(() {
        isError = false;
        _showSpinner = false;
      });
      print('sign in button tapped inside isError');
    }
    print('email: $email\n password:$pass\n');
    print('res value = $res\n');

    if (res) {
      setState(() {
        _showSpinner = false;
      });
      print('sign in button tapped inside res');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        ModalRoute.withName(HomePage.routeName),
      );
    } else {
      setState(() {
        _showSpinner = false;
        _loginFailed = true;
        isError = true;
      });
      print('sign in button tapped inside else statment');
      _errorMsg = provider.signInErrorMsg; //.split(".")[0];
      print(_errorMsg);
    }
    if (provider.currentUser == null || !provider.currentUser.emailVerified) {
      setState(() {
        _showSpinner = false;
      });
      print('sign in button tapped inside user == null ');
      print('current user ${provider.currentUser.email} not verify\n');
      _notVerifyAlert(context);
    }
  }

  void _notVerifyAlert(context) {
    Alert(
      context: context,
      title: 'You are not verify yet',
      desc: 'an email has been sent to you , please verify your email',
      type: AlertType.error,
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "OK!",
            style: TextStyle(color: Colors.white),
          ),
        ),
        DialogButton(
          onPressed: () {
            Provider.of<AuthService>(context, listen: false)
                .sendEmailVerification();
            Navigator.of(context).pop();
          },
          child: Text(
            "Re-send verification",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ).show();
  }
}
