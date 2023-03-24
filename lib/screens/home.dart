import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastedtalent/widgets/bottom_app_nav.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomAppNav(index: 0),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerboxScrolled) => [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  actions: [
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
                              'Explore',
                              style: TextStyle(
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
          body: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Categories"),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.architecture,
                                        color: Colors.purpleAccent,size: 32,
                                      ),
                                      Text(
                                        "Local handicrafts",
                                        style: GoogleFonts.lato(
                                            color: Colors.purpleAccent),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Text("Recommended"),
                    Row(children: [
                      Expanded(flex: 1,child: Image(image: NetworkImage("url"))),
                      Expanded(flex: 3,child: Column(children: [
                        Text("Title"),
                        Text("SubHeading")
                      ],))
                    ],)
                  ],
                );
              })),
    ));
  }
}
