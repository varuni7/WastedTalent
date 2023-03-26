import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastedtalent/screens/analytics/chart.dart';
import 'package:wastedtalent/services/sales/getSales.dart';
import 'package:wastedtalent/widgets/bottom_app_nav.dart';

import '../profile/profile.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  List<Padding> orders = [];
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    //_auth!.signOut();
    init_wrapper();
    // _user = _auth!.currentUser;
  }
  init_wrapper()async{
    List lorders = await getSales(_auth.currentUser?.uid);
    setState(() {
      orders = lorders.map((e){
        return Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: InkWell(onTap: (){
            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Messages()));
          },
            child: Container(width: MediaQuery.of(context).size.width,
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
                    Text("Title",style: GoogleFonts.metrophobic(fontWeight: FontWeight.bold),),
                    Text(e['Quantity'],style: GoogleFonts.metrophobic(),)
                  ],
                ),
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
          bottomNavigationBar: BottomAppNav(index: 2),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerboxScrolled) => [
                SliverAppBar(backgroundColor: Colors.white70,
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
                              'Sales',
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
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                    child: Text("Active Orders/Your Orders",style: GoogleFonts.metrophobic(fontWeight: FontWeight.bold,fontSize: 18),),
                  ),]+(orders.length==0?[Padding(padding: EdgeInsets.all(4),child: Center(child: Text("No active orders")),)]:orders)+[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BarChartSample2(),
                  )
                ],)
                    ,
              )),
        ));
  }
}
