import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
                    TextField(
                      style: TextStyle(fontSize: 18.0),
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
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
                    TextField(
                      style: TextStyle(fontSize: 18.0),
                      controller: password,
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
                          onPressed: () {
                            //Todo: Send OTP to registered number and confirm it.
                            print(email.text);
                            print(password.text);
                            email.clear();
                            password.clear();
                          }),
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
    );
  }
}
