import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/searchResults.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _city;
  String _state;
  String blood = "A+";
  bool bloodDonor = false;
  bool platDonor = false;
  bool plasDonor = false;

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
          "Search Donors!",
          style: GoogleFonts.lobsterTwo(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: new ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 20.0,
                    child: Container(
                      height: 300.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.redAccent,
                            Colors.deepOrange,
                            Colors.deepOrangeAccent,
                            Colors.orange,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 40.0),
                      child: TextFormField(
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
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: TextFormField(
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
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 80.0),
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
                                color: Colors.white,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Row(
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
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
                            "Search",
                            style: TextStyle(fontSize: 22.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchResults(
                                  city: _city,
                                  state: _state,
                                  blood: blood,
                                  bldon: bloodDonor,
                                  plasdon: plasDonor,
                                  platdon: platDonor,
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
