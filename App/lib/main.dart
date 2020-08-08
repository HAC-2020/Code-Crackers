import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash.dart';
import 'login.dart';
import 'register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/loginpage': (BuildContext context) => Login(),
        '/registerpage': (BuildContext context) => Register(),
        // '/homepage': (BuildContext context) => Dashboard(),
      },
      theme: ThemeData(
        // accentColor: Colors.redAccent,
        primaryColor: Color(0xff382b73),
      ),
    );
  }
}
