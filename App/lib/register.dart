import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController fName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  String dob = "Date Of Birth";
  String blood = "A+";
  Color dobColor = Colors.black54;
  bool bloodDonor = false;
  bool platDonor = false;
  bool plasDonor = false;

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Join Our Family!",
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
                  TextField(
                    style: TextStyle(fontSize: 18.0),
                    controller: fName,
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
                  TextField(
                    style: TextStyle(fontSize: 18.0),
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
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
                  TextField(
                    style: TextStyle(fontSize: 18.0),
                    controller: pass,
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
                              style: TextStyle(fontSize: 18.0, color: dobColor),
                            )),
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
                                setState(() {
                                  blood = value;
                                });
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
                      Checkbox(
                          activeColor: Colors.red,
                          value: bloodDonor,
                          onChanged: (value) {
                            setState(() {
                              bloodDonor = !bloodDonor;
                            });
                          }),
                      Text(
                        "Blood",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Checkbox(
                          activeColor: Colors.red,
                          value: platDonor,
                          onChanged: (value) {
                            setState(() {
                              platDonor = !platDonor;
                            });
                          }),
                      Text(
                        "Platelets",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Checkbox(
                        activeColor: Colors.red,
                        value: plasDonor,
                        onChanged: (value) {
                          setState(() {
                            plasDonor = !plasDonor;
                          });
                        },
                      ),
                      Text(
                        "Plasma",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
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
                          "Register",
                          style: TextStyle(fontSize: 22.0),
                        ),
                        onPressed: () {
                          //TODO: Register into Firebase.
                          print("Full Name: ${fName.text}");
                          print("Email ID: ${email.text}");
                          print("Password: ${pass.text}");
                          print("DOB: $dob");
                          print("Blood Group: $blood");
                          print("Blood Donor: $bloodDonor");
                          print("Platelets Donor: $platDonor");
                          print("Plasma Donor: $plasDonor");
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
