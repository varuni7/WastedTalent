import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastedtalent/widgets/bottom_app_nav.dart';

import '../../services/learn/getWorkshops.dart';
import '../profile/profile.dart';
import 'addEvent.dart';

class Learn extends StatefulWidget {
  const Learn({Key? key}) : super(key: key);

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {

  FirebaseAuth? _auth;
  List products = [];

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
    var lproducts = await getWorkshops();
    print(lproducts);
    setState(() {
      products = lproducts;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomAppNav(index: 3),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerboxScrolled) => [
                SliverAppBar(backgroundColor: Colors.white70,
                  actions: [                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEvent()));
                      },
                      icon: Icon(Icons.add)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        icon: Icon(Icons.perm_identity)),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.notifications))
                  ],
                  expandedHeight: MediaQuery.of(context).size.height * 0.25,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(children: [
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.25,
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
                          top: MediaQuery.of(context).size.height * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              'Learn',
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
                                          labelText: 'Search for any course',
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
                                          onPressed: () {},
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
              body: Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: InkWell(onTap: (){
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Messages()));
                        },
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 5),
                              ),
                            ],
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(products[index]['name'],style: GoogleFonts.metrophobic(fontWeight: FontWeight.bold),),
                                  Text(products[index]['dateTime'],style: GoogleFonts.metrophobic(),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )),
        ));
  }
}
