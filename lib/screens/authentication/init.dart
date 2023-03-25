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
      backgroundColor: Colors.grey.shade100,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      "Welcome To Wasted Talent",
                      style: GoogleFonts.metrophobic(
                        fontSize: 26,color: Colors.deepPurple[700],fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: SizedBox(width:400 ,height: 200,
                        child: const Image(
                            height: 200,
                            width: 400,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://inc42.com/wp-content/uploads/2023/03/ecommerce-feature-760x570.png")),
                      )),
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
                          color: Colors.deepPurple,
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
                              'Login',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.metrophobic(
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
