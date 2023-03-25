import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastedtalent/screens/profile/addProduct.dart';
import 'package:wastedtalent/screens/profile/viewProduct.dart';
import 'package:wastedtalent/services/getUserInfo.dart';
import 'package:wastedtalent/services/product/getProduct.dart';
import 'package:wastedtalent/services/product/getWork.dart';

import '../chat/messages.dart';

class Profile extends StatefulWidget {
  final uid;

  const Profile({Key? key, this.uid}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  bool expand = false;
  String story = "";
  String name = "";
  String url = "";
  FirebaseAuth? _auth;
  List products = [];
  List work = [];

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    //_auth!.signOut();
    init_wrapper();
    // _user = _auth!.currentUser;
  }

  init_wrapper() async {
    print("Widget");
    print(widget.uid);
    var userInfo = await getUserInfo(widget.uid==null?_auth?.currentUser?.uid:widget.uid);
    var lproducts = await getProduct(widget.uid==null?_auth?.currentUser?.uid:widget.uid);
    var lwork = await getWork(widget.uid==null?_auth?.currentUser?.uid:widget.uid);
    print(userInfo);
    setState(() {
      url = userInfo[1];
      name = userInfo[0]['name'];
      story = userInfo[0]['story'];
      products = lproducts;
      work = lwork;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                      child: Text(
                    "Wasted Talent",
                    style: GoogleFonts.metrophobic(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // construct the profile details widget here
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Row(
                  children: [
                    Expanded(
                        child: CircleAvatar(
                      backgroundColor: Colors.white54,
                      radius: 64,
                      backgroundImage: NetworkImage(url),
                    )),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.metrophobic(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        expand = expand ? false : true;
                      });
                    },
                    child: Text(expand
                        ? story
                        : (story.length > 120
                                ? story.substring(0, 120)
                                : story) +
                            "...")),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                child:widget.uid!=null? Row(
                  children: [
                    Expanded(
                      child: InkWell(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>Messages(uid:widget.uid,name:name,url:url)));
                      },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Chat",
                              style: GoogleFonts.metrophobic(
                                  color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Show on map",
                            style: GoogleFonts.metrophobic(
                                color: Colors.deepPurple, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ):Container(),
              ),
              // the tab bar with two items
              Container(
                height: 55,
                child: PreferredSize(
                  preferredSize: const TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.sell_outlined),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.work_history_outlined,
                        ),
                      ),
                    ],
                  ).preferredSize,
                  child: const Material(
                    color: Colors.white,
                    child: TabBar(
                      indicatorColor: Colors.deepPurple,
                      labelColor: Colors.deepPurple,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.sell_outlined),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.work_history_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    Expanded(
                        child: GridView.builder(
                            itemCount: widget.uid!=null?products.length : products.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 100),
                            itemBuilder: (context, int index) {
                              if(widget.uid!=null){
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ViewProduct(
                                              section: "Product",
                                              uid: products[index][0]["uid"],
                                              id: products[index][1],
                                            )));
                                  },
                                  child: Image(
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(jsonDecode(
                                          products[index][0]
                                          ['imgURL'])[0]
                                          .toString())),
                                );
                              }
                              if (index == 0) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => AddProduct(
                                                  section: "Product",
                                                )));
                                  },
                                  child: Stack(
                                    children: [
                                      Image(
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80")),
                                      Positioned(
                                          child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.black54),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ViewProduct(
                                                  section: "Product",
                                                  uid: products[index-1][0]["uid"],
                                                  id: products[index - 1][1],
                                                )));
                                  },
                                  child: Image(
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(jsonDecode(
                                              products[index - 1][0]
                                                  ['imgURL'])[0]
                                          .toString())),
                                );
                              }
                            })),

                    // second tab bar viiew widget
                    Expanded(
                        child: GridView.builder(
                            itemCount: widget.uid!=null?work.length:work.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 100),
                            itemBuilder: (context, int index) {
                              if(widget.uid!=null){
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ViewProduct(
                                              section: "Work",
                                              uid: products[index][0]["uid"],
                                              id: products[index][1],
                                            )));
                                  },
                                  child: Image(
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(jsonDecode(
                                          work[index][0]['imgURL'])[0]
                                          .toString())),
                                );
                              }
                              if (index == 0) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => AddProduct(
                                                  section: "Work",
                                                )));
                                  },
                                  child: Stack(
                                    children: [
                                      Image(
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80")),
                                      Positioned(
                                          child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.black54),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ViewProduct(
                                                  section: "Work",
                                                  uid: products[index-1][0]["uid"],
                                                  id: products[index - 1][1],
                                                )));
                                  },
                                  child: Image(
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(jsonDecode(
                                              work[index - 1][0]['imgURL'])[0]
                                          .toString())),
                                );
                              }
                            })),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
