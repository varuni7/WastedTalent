import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastedtalent/screens/profile/profile.dart';
import 'package:wastedtalent/services/notification/sendNotification.dart';
import 'package:wastedtalent/services/product/getProduct.dart';
import 'package:wastedtalent/services/product/getWork.dart';

import '../../services/getUserInfo.dart';
import '../../services/sales/buy.dart';

class ViewProduct extends StatefulWidget {
  final section;
  final id;
  final uid;

  const ViewProduct({Key? key, this.section, this.id, this.uid})
      : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  Map data = {"price": "", "description": "", "imgURL": "", "title": ""};
  int qty = 1;
  String name = "";
  bool loading = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    //_auth!.signOut();
    init_wrapper();
    // _user = _auth!.currentUser;
  }

  init_wrapper() async {
    var ldata;
    print(widget.section);
    print(widget.id);
    print(widget.uid);
    var userInfo = await getUserInfo(widget.uid);
    if (widget.section == "Product") {
      ldata = await getProductByID(widget.id);
    } else {
      ldata = await getWorkByID(widget.uid, widget.id);
    }
    setState(() {
      data = ldata;
      name = userInfo[0]['name'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CarouselSlider.builder(
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 3,
                            viewportFraction: 1),
                        itemCount: jsonDecode(data['imgURL']).length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return Image(
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  jsonDecode(data['imgURL'])[itemIndex]));
                        }),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                      child: Text(
                        data['title'],
                        style: GoogleFonts.metrophobic(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      Profile(uid: widget.uid)));
                        },
                        child: Text(
                          name,textAlign: TextAlign.center,
                          style: GoogleFonts.metrophobic(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      children: data['tags']
                          .toString()
                          .substring(1, data['tags'].length - 2)
                          .split(',')
                          .map((v) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.deepPurple[100]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                v,
                                style: GoogleFonts.metrophobic(
                                    color: Colors.deepPurple),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text("Rs." + data['price']),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    qty--;
                                  });
                                },
                                icon: Icon(Icons.remove)),
                            Text(
                              qty.toString(),
                              style: GoogleFonts.metrophobic(fontSize: 16),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    qty++;
                                  });
                                },
                                icon: Icon(Icons.add))
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        data['description'],
                        style: GoogleFonts.metrophobic(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          buy(widget.uid, qty, _auth.currentUser?.uid, widget.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.deepPurple[100]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Buy Now",
                              style: GoogleFonts.metrophobic(
                                  color: Colors.deepPurple, fontSize: 16),
                            ),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 4),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              var myuid =
                                  await getUserInfo(_auth.currentUser?.uid);
                              sendNotification(widget.uid, myuid[0]['name'],
                                  data['title'], 1);
                            },
                            icon: Icon(Icons.favorite)),
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: "Send a message",
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
                        IconButton(
                            onPressed: () async {
                              var myuid =
                                  await getUserInfo(_auth.currentUser?.uid);
                              sendNotification(widget.uid, myuid[0]['name'],
                                  messageController.text, 0);
                            },
                            icon: Icon(Icons.send)),
                      ],
                    ),
                  ),
                )
              ],
            )),
          );
  }
}
