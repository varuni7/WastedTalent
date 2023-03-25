import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:wastedtalent/screens/home/home.dart';
import 'package:wastedtalent/services/auth/newUser.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final age = TextEditingController();
  File? files = null;
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
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
                    child: Text(
                      "Add Your Personal Info",
                      style: GoogleFonts.metrophobic(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            final picker =
                                await FilePicker.platform.pickFiles();
                            final path = picker?.files.single.path;
                            setState(() {
                              files = File(path!);
                            });
                          },
                          child: files == null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.black54),
                                  width: 128,
                                  height: 128,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                            radius: 128,
                            backgroundImage:
                            FileImage(files!),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: age,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Story",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8.0, 24, 8),
                    child: Row(
                      children: [],
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
                    onPressed: () async {
                      await newUser(name.text, age.text, files, FirebaseAuth.instance.currentUser?.uid);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },

                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                      padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.zero),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade800,
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
                            'Submit',
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
      "Current Interests": age.text,
      "Future Interests": age.text,
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
