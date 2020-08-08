import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String password, fname, phone, dob, blood;
  bool bldon = false, platdon = false, plasdon = false;

  @override
  void initState() {
    // TODO: implement initState
    DocumentReference documentReference =
        Firestore.instance.collection("Users").document(email);
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        phone = datasnapshot.data['Phone Number'];
        fname = datasnapshot.data['Name'];
        // _email = datasnapshot.data["Email Id"].toString();
        dob = datasnapshot.data['Date of Birth'];
        blood = datasnapshot.data['Blood Group'];
        bldon = datasnapshot.data['Blood Donor'];
        platdon = datasnapshot.data['Platelets Donor'];
        plasdon = datasnapshot.data['Plasma Donor'];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffae6ef),
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.lobsterTwo(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Update()),
            ),
            icon: Icon(
              FontAwesomeIcons.pen,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/superhero.jpg",
            height: MediaQuery.of(context).size.height / 2.5,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: new ScrollBehavior()
                ..buildViewportChrome(context, null, AxisDirection.down),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    profileData(
                      data: "Name: $fname",
                      icon: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.blue,
                      ),
                    ),
                    profileData(
                      data: "Mobile: $phone",
                      icon: Icon(
                        FontAwesomeIcons.phone,
                        color: Colors.blue,
                      ),
                    ),
                    profileData(
                      data: "DOB: $dob",
                      icon: Icon(
                        FontAwesomeIcons.calendar,
                        color: Colors.green,
                      ),
                    ),
                    profileData(
                      data: "Blood Group: $blood",
                      icon: Icon(
                        FontAwesomeIcons.tint,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      height: 100.0,
                      child: Card(
                        child: Center(
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            spacing: 10.0,
                            children: <Widget>[
                              SizedBox(width: 5.0),
                              Icon(FontAwesomeIcons.quoteRight),
                              Text(
                                ' Donor Type:',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              Visibility(
                                visible: bldon,
                                child: Text(
                                  'Blood Donor',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: platdon,
                                child: Text(
                                  'Platelets Donor',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: plasdon,
                                child: Text(
                                  'Plasma Donor',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class profileData extends StatelessWidget {
  String data;
  Icon icon;
  profileData({this.data, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Card(
        child: Center(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 20.0,
              ),
              icon,
              SizedBox(
                width: 10.0,
              ),
              Text(
                data,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
