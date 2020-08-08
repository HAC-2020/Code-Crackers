import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'loading.dart';

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final _formKey = new GlobalKey<FormState>();

  String _pass;
  String _fname;
  String _email;
  String _phone;
  String _city;
  String _state;
  String dob = "Date Of Birth";
  String blood = "A+";
  Color dobColor = Colors.black54;
  bool bloodDonor = false;
  bool platDonor = false;
  bool plasDonor = false;
  bool none = false;

  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;

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
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
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
                  _auth.currentUser().then((user) async {
                    if (user != null) {
                      Map<String, dynamic> data = <String, dynamic>{
                        "Name": _fname,
                        "Email Id": _email,
                        "Password": _pass,
                        "Phone Number": _phone,
                        "Date of Birth": dob,
                        "Blood Group": blood,
                        "Blood Donor": bloodDonor,
                        "Platelets Donor": platDonor,
                        "Plasma Donor": plasDonor,
                        "City": _city,
                        "State": _state,
                        "Registered On": Timestamp.now(),
                      };
                      await db
                          .collection("Users")
                          .document(_email)
                          .setData(data)
                          .whenComplete(() {
                        print("Form Added");
                      }).catchError((e) => print(e));
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Toast.show("You have successfully Updated", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      FirebaseAuth.instance.signOut();
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
      Map<String, dynamic> data = <String, dynamic>{
        "Name": _fname,
        "Email Id": _email,
        "Password": _pass,
        "Phone Number": _phone,
        "Date of Birth": dob,
        "Blood Group": blood,
        "Blood Donor": bloodDonor,
        "Platelets Donor": platDonor,
        "Plasma Donor": plasDonor,
        "City": _city,
        "State": _state,
        "Registered On": Timestamp.now(),
      };
      await db
          .collection("Users")
          .document(_email)
          .setData(data)
          .whenComplete(() {
        print("Form Added");
      }).catchError((e) => print(e));
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/loginpage');
      Toast.show("You have successfully Updated Details", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      FirebaseAuth.instance.signOut();
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

  @override
  initState() {
    super.initState();
    auth.onAuthStateChanged.listen((u) {
      setState(() => user = u);
    });
  }

  void chooseDate() async {
    FocusScope.of(context).unfocus();
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1000),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
    );
    setState(() {
      if (newDateTime != null)
        dob = newDateTime.day.toString() +
            ' / ' +
            newDateTime.month.toString() +
            ' / ' +
            newDateTime.year.toString();
      dobColor = Colors.black;
    });
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    Text(
                      "Wrong Details? No Problem, Update It!",
                      style: GoogleFonts.lobsterTwo(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return 'Name is required';
                        return null;
                      },
                      onChanged: (value) => _fname = value,
                      style: TextStyle(fontSize: 18.0),
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "Full Name",
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
                        if (value.isEmpty) return 'Email ID is required';
                        if (!RegExp(
                                r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                            .hasMatch(value))
                          return 'Please enter a valid Email ID';
                        return null;
                      },
                      onChanged: (value) => _email = value,
                      style: TextStyle(fontSize: 18.0),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email ID",
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
                      onChanged: (value) => _pass = value,
                      style: TextStyle(fontSize: 18.0),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
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
                        if (value.isEmpty) return 'Phone no is required';
                        return null;
                      },
                      onChanged: (value) => _phone = value,
                      style: TextStyle(fontSize: 18.0),
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "Phone No",
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
                    GestureDetector(
                      onTap: chooseDate,
                      child: Container(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dob,
                                style:
                                    TextStyle(fontSize: 18.0, color: dobColor),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return 'City is required';
                        return null;
                      },
                      onChanged: (value) => _city = value,
                      style: TextStyle(fontSize: 18.0),
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "City",
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
                        if (value.isEmpty) return 'State is required';
                        return null;
                      },
                      onChanged: (value) => _state = value,
                      style: TextStyle(fontSize: 18.0),
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "State",
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
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Blood Group",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            height: 50.0,
                            width: 80.0,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: blood,
                                onChanged: (value) {
                                  setState(() => blood = value);
                                },
                                items: <DropdownMenuItem<dynamic>>[
                                  DropdownMenuItem(
                                    child: Text("A+"),
                                    value: "A+",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("O+"),
                                    value: "O+",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("B+"),
                                    value: "B+",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("AB+"),
                                    value: "AB+",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("A-"),
                                    value: "A-",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("O-"),
                                    value: "O-",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("B-"),
                                    value: "B-",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("AB-"),
                                    value: "AB-",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "What Are You Willing To Donate? ",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Checkbox(
                              activeColor: Colors.red,
                              value: bloodDonor,
                              onChanged: (value) {
                                setState(() => bloodDonor = !bloodDonor);
                              }),
                        ),
                        Text(
                          "Blood",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Expanded(
                          child: Checkbox(
                              activeColor: Colors.red,
                              value: platDonor,
                              onChanged: (value) {
                                setState(() => platDonor = !platDonor);
                              }),
                        ),
                        Text(
                          "Platelets",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Expanded(
                          child: Checkbox(
                            activeColor: Colors.red,
                            value: plasDonor,
                            onChanged: (value) {
                              setState(() => plasDonor = !plasDonor);
                            },
                          ),
                        ),
                        Text(
                          "Plasma",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Expanded(
                          child: Checkbox(
                            activeColor: Colors.red,
                            value: none,
                            onChanged: (value) {
                              setState(() => none = !none);
                            },
                          ),
                        ),
                        Text(
                          "None",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Container(
                      height: 60.0,
                      width: 150.0,
                      child: RaisedButton(
                        color: Colors.redAccent.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        child: Text(
                          "Update",
                          style: TextStyle(fontSize: 22.0),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            phoneNo = _phone;
                            verifyPhone();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
