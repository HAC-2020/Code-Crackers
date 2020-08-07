import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/login.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("images/splash.jpg"),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Lifeline",
            style: GoogleFonts.lobsterTwo(
              textStyle: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Be A Hero!",
            style: GoogleFonts.lobsterTwo(
              textStyle: TextStyle(
                fontSize: 25.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            height: 60.0,
            width: 150.0,
            child: RaisedButton(
              elevation: 20.0,
              color: Colors.redAccent.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
              child: Text(
                "Let's do it!",
                style: TextStyle(fontSize: 22.0),
              ),
              onPressed: () => Navigator.of(context).pushReplacement(
                PageTransition(
                  type: PageTransitionType.slideZoomLeft,
                  child: Login(),
                  duration: Duration(seconds: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
