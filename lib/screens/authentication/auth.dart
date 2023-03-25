import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:wastedtalent/screens/authentication/personalInfo.dart';

import '../home/home.dart';
import 'init.dart';

enum ScreenState { MOBILE_NO_STATE, OTP_STATE }

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  ScreenState curr_state = ScreenState.MOBILE_NO_STATE;
  final mobFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  String mob_no = "";
  String otp = "";
  String countryCode = "+91";
  String? _verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      String? uid = _auth.currentUser!.uid;
      final snapshot = await FirebaseDatabase.instance.ref('users/$uid').get();
      if (snapshot.exists) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PersonalInfo()));
      }
      //  Navigator.pushReplacement(
      //      context, MaterialPageRoute(builder: (context) => PersonalInfo()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  Widget get_mob_state(BuildContext context) {
    return Form(
      key: mobFormKey,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32,bottom: 32.0),
            child: Text(
              "Login",
              style: GoogleFonts.metrophobic(
                  fontSize: 26,color: Colors.deepPurple[700],fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CountryCodePicker(
                    onChanged: (val) {
                      countryCode = val.toString();
                    },
                    initialSelection: "IN",
                    showFlagMain: false,
                    textStyle: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.black),
                    dialogSize: Size(300, 400)),
                Container(
                  width: 250,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.metrophobic(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Enter Phone no",

                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.grey.shade100
                          )
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.length != 10) {
                        return "Please enter a valid moble number.";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => setState(() {
                      mob_no = value!;
                    }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: TextButton(
              onPressed: () async {
                final isValid = mobFormKey.currentState!.validate();
                if (isValid) {
                  mobFormKey.currentState!.save();

                  setState(() {
                    showLoading = true;
                  });
                  await _auth.verifyPhoneNumber(
                      timeout: const Duration(seconds: 120),
                      phoneNumber: countryCode + mob_no,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });

                        signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(verificationFailed.message!),
                            duration: const Duration(seconds: 5)));
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showLoading = false;
                          curr_state = ScreenState.OTP_STATE;
                          _verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InitializerWidget(
                                  registering: true,
                                )));
                      });
                }
              },
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                padding: MaterialStateProperty.resolveWith(
                        (states) => EdgeInsets.zero),
              ),
              child: Ink(
                decoration:  BoxDecoration(
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
                      'Get OTP',
                      textAlign: TextAlign.center,
                      style:
                      GoogleFonts.metrophobic(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 12,
          ),
        ],
      ),
    );
  }

  //TODO: Impement a good otp entry field
  Widget get_otp_state(BuildContext context) {
    return Form(
      key: otpFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 12),
          // TextFormField(
          //   keyboardType: TextInputType.number,
          //   onSaved: (value) => setState(() {
          //     otp = value!;
          //   }),
          //   validator: (val) {
          //     if (val!.length != 6) {
          //       return "Enter valid OTP";
          //     } else {
          //       return null;
          //     }
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 32,bottom: 32.0),
            child: Text(
              "Enter OTP",
              style: GoogleFonts.metrophobic(
                  fontSize: 26,color: Colors.deepPurple[700],fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),
          ),
          OTPTextField(
            otpFieldStyle: OtpFieldStyle(focusBorderColor:  Colors.deepPurple.shade800),
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 40,
            style: GoogleFonts.metrophobic(fontSize: 17, color:  Colors.deepPurple.shade800),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) {
              otp = pin;
              onOtpPressed();
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: TextButton(
              onPressed: onOtpPressed,
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                padding: MaterialStateProperty.resolveWith(
                        (states) => EdgeInsets.zero),
              ),
              child: Ink(
                decoration:  BoxDecoration(
                  color:  Colors.deepPurple.shade800,
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
                      'Verify',
                      textAlign: TextAlign.center,
                      style:
                      GoogleFonts.metrophobic(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 12),
        ],
      ),
    );
  }

  void onOtpPressed() async {
    final isValid = otpFormKey.currentState!.validate();
    if (isValid) {
      otpFormKey.currentState!.save();
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otp);

      signInWithPhoneAuthCredential(phoneAuthCredential);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffFEFCF3),
        body: Stack(
          children: [
            showLoading
                ? Center(child: CircularProgressIndicator())
                : curr_state == ScreenState.MOBILE_NO_STATE
                ? get_mob_state(context)
                : get_otp_state(context),
          ],
        ));
  }
}
