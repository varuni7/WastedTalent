import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:wastedtalent/screens/home.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final age = TextEditingController();
  FirebaseAuth? _auth;
  final name = TextEditingController();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    //_auth!.signOut();
    init_wrapper();
    // _user = _auth!.currentUser;
  }

  init_wrapper() async {
    print("this is running");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 24, 0, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 48.0, 24, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: name,
                            style: GoogleFonts.alata(color: Colors.black),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffFDF2C9),
                                focusColor: Color(0xffFDF2C9),
                                hoverColor: Color(0xffFDF2C9),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xff12253A))),
                                labelText: "name",
                                labelStyle: GoogleFonts.alata(
                                    fontSize: 16, color: Color(0xff12253A))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8.0, 24, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: age,
                            style: GoogleFonts.alata(color: Colors.black),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffFDF2C9),
                                focusColor: Color(0xffFDF2C9),
                                hoverColor: Color(0xffFDF2C9),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color(0xff12253A))),
                                labelText: "age",
                                labelStyle: GoogleFonts.alata(
                                    fontSize: 16, color: Color(0xff12253A))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8.0, 24, 8),
                    child: Row(
                      children: [

                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        color: Colors.black.withOpacity(0.25))
                  ]),
                  child: TextButton(
                    onPressed:() async {
                      await personal_added();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home()));
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                      padding: MaterialStateProperty.resolveWith(
                              (states) => EdgeInsets.zero),
                    ),
                    child: Ink(
                      decoration: const BoxDecoration(
                        color: Color(0xff12253A),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 88.0,
                            minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'submit',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alata(
                                color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  personal_added() async {
    var loc = await Location().getLocation();
    print(_auth?.currentUser);
    DatabaseReference ref =
    FirebaseDatabase.instance.ref('users/' + _auth!.currentUser!.uid);
    String latlong = loc.latitude.toString() + ',' + loc.longitude.toString();
    await ref.set({
      "Name": name.text,
      "Age": age.text,
      "Gender": age.text,
      "Current Interests":
      age.text,
      "Future Interests":
      age.text,
      'location': latlong
    });
    /*
    List currentinterest =
    _cntMult.dropDownValueList!.map((e) => e.name).toList();
    List futureinterest =
    _cntMulti.dropDownValueList!.map((e) => e.name).toList();

    for (int i = 0; i < currentinterest.length; i++) {
      String nameofchannel = currentinterest[i];
      FirebaseDatabase.instance
          .ref('channels/$nameofchannel')
          .update({_auth!.currentUser!.uid: 'Current Interests'});
    }

    for (int i = 0; i < futureinterest.length; i++) {
      String nameofchannel = futureinterest[i];
      FirebaseDatabase.instance
          .ref('channels/$nameofchannel')
          .update({_auth!.currentUser!.uid: 'Future Interests'});
    }
    */
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }
}
