import 'package:app/auth/auth_service.dart';
import 'package:app/model/user_model.dart';
import 'package:app/screens/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../main.dart';
import 'emailverification_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _lastNameFocus = FocusNode();

  final _emailFocus = FocusNode();
  var _showSpinner = false;

  final _passFocus = FocusNode();

  final _form = GlobalKey<FormState>();
  var isError = false;
  var emailFocus = false;

  var _isEmailValid = false;

  var user = UserModel(
      firstName: "",
      lastName: "",
      email: "",
      password: "",
      score: 0,
      tips: tips.toList());

  // @override
  // void dispose() {
  //   _lastNameFocus.dispose();
  //   _emailFocus.dispose();
  //   _passFocus.dispose();
  //   super.dispose();
  // }

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
                      "Create account",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto-Medium',
                          fontSize: 34.0),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: media.size.height * 0.2,
                    child: Image.asset("images/global.png"),
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
                            onSaved: (val) {
                              user = UserModel(
                                firstName: val,
                                lastName: user.firstName,
                                email: user.email,
                                password: user.password,
                              );
                            },
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_lastNameFocus);
                            },
                            validator: (enteredText) {
                              if (enteredText.isEmpty) {
                                return "Please entered your first name";
                              } else {
                                return null;
                              }
                            },
                            decoration: kTextFieldform.copyWith(
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontFamily: "Roboto-Medium"),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Enter first name"),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            textInputAction: TextInputAction.next,
                            onSaved: (lastName) {
                              user = UserModel(
                                  firstName: user.firstName,
                                  lastName: lastName,
                                  email: user.email,
                                  password: user.password,
                                  tips: user.tips,
                                  score: user.score);
                            },
                            focusNode: _lastNameFocus,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_emailFocus);
                            },
                            validator: (enteredText) {
                              if (enteredText.isEmpty) {
                                return "Please entered your last name";
                              } else {
                                return null;
                              }
                            },
                            decoration: kTextFieldform.copyWith(
                                prefixIcon: Icon(Icons.person),
                                hintText: "Enter Last name"),
                          ),
                          SizedBox(height: 20),
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
                              } else if (!EmailValidator.validate(
                                  enteredText)) {
                                return "please entered valid email";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (email) {
                              user = UserModel(
                                  firstName: user.firstName,
                                  lastName: user.lastName,
                                  email: email,
                                  password: user.password,
                                  tips: user.tips,
                                  score: user.score);
                            },
                            onChanged: (email) {
                              if (!EmailValidator.validate(email)) {
                                setState(() {
                                  _isEmailValid = false;
                                });
                              } else if (EmailValidator.validate(email)) {
                                setState(() {
                                  _isEmailValid = true;
                                });
                              }
                            },
                            decoration: kTextFieldform.copyWith(
                              suffixIcon: _isEmailValid
                                  ? Icon(Icons.check_circle)
                                  : null,
                              prefixIcon: Icon(Icons.email),
                              hintText: "Enter Email",
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            focusNode: _passFocus,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            validator: (enteredText) {
                              if (enteredText.isEmpty) {
                                return "Password cannot be empty";
                              } else if (enteredText.length < 8) {
                                return "password length must be at least 8 character";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (pass) {
                              user = UserModel(
                                  firstName: user.firstName,
                                  lastName: user.lastName,
                                  email: user.email,
                                  password: pass,
                                  tips: user.tips,
                                  score: user.score);
                            },
                            onChanged: (_) {
                              print('value of email focus = ' +
                                  _emailFocus.hasFocus.toString());
                              // signUpForm();
                              // FocusScope.of(context).unfocus();
                            },
                            decoration: kTextFieldform.copyWith(
                                prefixIcon: Icon(Icons.lock),
                                hintText: "Enter Password"),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: TextButton(
                              onPressed: signUpForm,
                              child: Text(
                                "Sign up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Roboto-Regular",
                                    fontSize: 20),
                              ),
                            ),
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
                            text: 'Already have account? ',
                            style: TextStyle(
                                fontFamily: 'Roboto-Regular', fontSize: 18),
                          ),
                          TextSpan(
                            text: 'Sign in',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushReplacementNamed(
                                    LoginScreen.routeName);
                              },
                            style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                fontSize: 18,
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

  void signUpForm() async {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      setState(() {
        isError = true;
      });
      return;
    }
    if (isError) {
      setState(() {
        isError = false;
      });
    }
    _form.currentState.save();
    setState(() {
      _showSpinner = true;
    });
    var provider = Provider.of<AuthService>(context, listen: false);
    bool signUpSuccessful = await provider.signUp(userModel: user);

    if (signUpSuccessful) {
      setState(() {
        _showSpinner = false;
      });
      provider.sendEmailVerification();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => ConfirmEmail()),
        ModalRoute.withName(ConfirmEmail.routeName),
      );
    } else {
      //TODO: handle sign up error if user is already register with same email
    }
  }
}
