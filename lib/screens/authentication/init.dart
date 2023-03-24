import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth.dart';

class InitializerWidget extends StatefulWidget {
  final registering;
  const InitializerWidget({Key? key, this.registering}) : super(key: key);

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xffFEFCF3),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose language",
                    style: GoogleFonts.alata(
                      fontSize: 26,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Authenticate()));
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 88.0,
                              minHeight:
                              36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'login',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.alata(
                                  color: Colors.white, fontSize: 24),
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
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          )
        ],
      ),
    );
  }
}
