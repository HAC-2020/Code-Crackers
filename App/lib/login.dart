import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/home.dart';
import 'package:lifeline/register.dart';
import 'package:toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'loading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = new GlobalKey<FormState>();

  String _password;
  String _fname;
  String _email;

  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone() async {
    FocusScope.of(context).unfocus();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 50.0,
            width: 50.0,
            child: Loading(),
          );
        });
    Toast.show(
        "OTP has been sent to your registered number. Please Wait...\n\nIf you don't receive otp, you have been blocked by our server for multiple logins in a day. Please try again after 24 hours",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP);
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title:
                Text('Enter OTP', style: TextStyle(color: Color(0xff382b73))),
            content: Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              height: 85,
              child: Column(children: [
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onChanged: (value) => this.smsOTP = value,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                (errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done', style: TextStyle(color: Color(0xff382b73))),
                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                      Toast.show("You have successfully signed in", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    } else {
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/registerpage');
      Toast.show("You have successfully signed in", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid OTP';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      case 'We have blocked all requests from this device due to unusual activity. Try again later.':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage =
              'You have been blocked by our server for multiple logins in a day. Please try again after 24 hours';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });
        break;
    }
  }

  void submit() async {
    if (_formKey.currentState.validate()) {
      DocumentReference documentReference =
          Firestore.instance.collection("Users").document(_email);
      documentReference.get().then((datasnapshot) {
        if (datasnapshot.exists) {
          if (_password == datasnapshot.data['Password'].toString()) {
            phoneNo = datasnapshot.data['Phone Number'].toString();
            _fname = datasnapshot.data['Name'].toString();
            _email = datasnapshot.data["Email Id"].toString();
            verifyPhone();
          } else
            Toast.show("Invalid Password!!!", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        } else
          Toast.show("User not registered!!!", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffae6ef),
      body: Center(
        child: ScrollConfiguration(
          behavior: new ScrollBehavior()
            ..buildViewportChrome(context, null, AxisDirection.down),
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: GoogleFonts.lobsterTwo(
                          fontSize: 50.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Image.asset("images/login.jpg"),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return 'Email ID is required';
                          if (!RegExp(
                                  r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                              .hasMatch(value))
                            return 'Please enter a valid Email ID';
                          return null;
                        },
                        style: TextStyle(fontSize: 18.0),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => _email = value,
                        decoration: InputDecoration(
                          hintText: "Enter Email ID",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return 'Password is required';
                          if (value.length < 8)
                            return 'Password should be of more than 8 characters';
                          return null;
                        },
                        style: TextStyle(fontSize: 18.0),
                        onChanged: (value) => _password = value,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Colors.redAccent.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 22.0),
                          ),
                          onPressed: submit,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            child: Text(
                              "Forgot Password!",
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black54),
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.rippleMiddle,
                                child: Register(),
                                duration: Duration(seconds: 1),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "New User? ",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black54),
                                ),
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.red.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
