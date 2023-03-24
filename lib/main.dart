import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:wastedtalent/screens/authentication/init.dart';
import 'package:wastedtalent/screens/authentication/personalInfo.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth? _auth;
  User? _user;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
 Timer(Duration(seconds: 3),()=>{
 route()
 });

  }

  Future<void> route() async {
    //  if (_user == null) {
    //    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //      Navigator.pushReplacement(
    //          context, MaterialPageRoute(builder: (context) => Authenticate()));
    //    });}
    print(_user?.uid);
    if (_user?.uid != null) {
      String? uid = _user?.uid;
      final snapshot = await FirebaseDatabase.instance.ref('users/$uid').get();
      print(snapshot.exists);
      if (snapshot.exists) {
      //  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
      //  });
      } else {
       // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => PersonalInfo()));
       // });
      }
    }
    else{
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>InitializerWidget()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80'),
                      fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff12253A),
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                      child: Text(
                        "Ya",
                        style: GoogleFonts.dancingScript(
                            color: Colors.white, fontSize: 64),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "app_name",
                      style:
                      GoogleFonts.alata(color: Color(0xff12253A), fontSize: 30),
                    ),
                  )
                ],
              )),
        ));
  }
}
