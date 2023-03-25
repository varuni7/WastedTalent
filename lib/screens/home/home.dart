import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastedtalent/models/categories.dart';
import 'package:wastedtalent/screens/home/search.dart';
import 'package:wastedtalent/screens/notifications.dart';
import 'package:wastedtalent/screens/profile/profile.dart';
import 'package:wastedtalent/services/recommendLocalShops.dart';
import 'package:wastedtalent/widgets/bottom_app_nav.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SingleChildRenderObjectWidget> recommendations = [];
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    //_auth!.signOut();
    init_wrapper();
    // _user = _auth!.currentUser;
  }

  init_wrapper() async {
    List recommendation = await recommendLocalShops(_auth.currentUser?.uid);


    setState(() {
    recommendations = recommendation.map((e){
      print("Recommendation");
      print(e);
      print(e[0][0]["work"]);
      return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 16),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder)=>Profile(uid:e[1])));},
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
                color: Colors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(40),
                            child:  Image(
                                height: 64,
                                width: 64,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    e[0][1])),
                          )),
                    ),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          e[0][0]["name"],
                          style: GoogleFonts.metrophobic(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          e[0][0]['story'].toString().substring(0,20)+'...',
                          style: GoogleFonts.metrophobic(),
                        )
                      ],
                    )
                  ],
                ),
                e[0][0]["work"]==null?Container(): SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 81,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: e[0][0]["work"].keys.length,
                      itemBuilder: (context, index) {
                        //:TODO Change this
                        if (index == e[0][0]["work"].keys.length-1 && e[0][0]["work"].keys.length>4) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(8),
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(28),
                                  child: InkWell(
                                    onTap: () {
                                      showImageViewer(
                                          context,
                                          Image.network(
                                              jsonDecode(e[0][0]["work"][e[0][0]["work"].keys.toList()[index]]['imgURL'])[0])
                                              .image,
                                          swipeDismissible:
                                          false);
                                    },
                                    child: Stack(
                                      children: [
                                        Image(
                                            height: 64,
                                            width: 64,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                jsonDecode(e[0][0]["work"][e[0][0]["work"].keys.toList()[index]]['imgURL'])[0])),
                                        Positioned(
                                            child: Container(
                                              width: 64,
                                              height: 64,
                                              decoration:
                                              BoxDecoration(
                                                  color: Colors
                                                      .black38),
                                              child: Icon(
                                                Icons.more_horiz,
                                                color: Colors.white,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(8),
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(28),
                                  child: InkWell(
                                    onTap: () {
                                      showImageViewer(
                                          context,
                                          Image.network(
                                              jsonDecode(e[0][0]["work"][e[0][0]["work"].keys.toList()[index]]['imgURL'])[0])
                                              .image,
                                          swipeDismissible:
                                          false);
                                    },
                                    child:  Image(
                                        height: 64,
                                        width: 64,
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            jsonDecode(e[0][0]["work"][e[0][0]["work"].keys.toList()[index]]['imgURL'])[0])),
                                  ),
                                )),
                          );
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      );
    }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomAppNav(index: 0),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerboxScrolled) =>
              [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        icon: Icon(Icons.perm_identity)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>Notifications()));
                        }, icon: Icon(Icons.notifications))
                  ],
                  expandedHeight: MediaQuery
                      .of(context)
                      .size
                      .height * 0.25,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(children: [
                      Column(
                        children: [
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.25,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(36),
                                    bottomRight: Radius.circular(36))),
                          ),
                        ],
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              'Explore',
                              style: GoogleFonts.metrophobic(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Positioned(
                          bottom: 15,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 54,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 32.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      flex: 3,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Search for any item',
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff564787))),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff564787))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff564787))),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ExploreSearch()));
                                          },
                                          child: const Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ]),
                  ),
                ),
              ],
              body: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                          child: Text(
                            "Categories",
                            style: GoogleFonts.metrophobic(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: category.length,
                              itemBuilder: (context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurple[100],
                                        borderRadius: BorderRadius.circular(
                                            12)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Icon(
                                            Icons.architecture,
                                            color: Colors.deepPurple,
                                            size: 32,
                                          ),
                                          Text(
                                            category[index],
                                            style: GoogleFonts.lato(
                                                color: Colors.deepPurple),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 0),
                          child: Text("Recommended",
                              style: GoogleFonts.metrophobic(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                        ),
                 /*       Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: InkWell(
                            onTap: () {
                              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Messages()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                16),
                                            child: SizedBox.fromSize(
                                              size: Size.fromRadius(40),
                                              child: const Image(
                                                  height: 64,
                                                  width: 64,
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80")),
                                            )),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Shop Name",
                                            style: GoogleFonts.metrophobic(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Story ...",
                                            style: GoogleFonts.metrophobic(),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 32,
                                    height: 81,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          //:TODO Change this
                                          if (index == 9) {
                                            return Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  child: SizedBox.fromSize(
                                                    size: Size.fromRadius(28),
                                                    child: InkWell(
                                                      onTap: () {
                                                        showImageViewer(
                                                            context,
                                                            Image
                                                                .network(
                                                                "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80")
                                                                .image,
                                                            swipeDismissible:
                                                            false);
                                                      },
                                                      child: Stack(
                                                        children: [
                                                          Image(
                                                              height: 64,
                                                              width: 64,
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80")),
                                                          Positioned(
                                                              child: Container(
                                                                width: 64,
                                                                height: 64,
                                                                decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .black38),
                                                                child: Icon(
                                                                  Icons
                                                                      .more_horiz,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            );
                                          } else {
                                            return Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  child: SizedBox.fromSize(
                                                    size: Size.fromRadius(28),
                                                    child: InkWell(
                                                      onTap: () {
                                                        showImageViewer(
                                                            context,
                                                            Image
                                                                .network(
                                                                "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80")
                                                                .image,
                                                            swipeDismissible:
                                                            false);
                                                      },
                                                      child: const Image(
                                                          height: 64,
                                                          width: 64,
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80")),
                                                    ),
                                                  )),
                                            );
                                          }
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),*/
                      ]+recommendations,
                    );
                  })),
        ));
  }
}
