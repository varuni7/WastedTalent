import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastedtalent/models/backendUrl.dart';
import 'package:wastedtalent/screens/profile/viewProduct.dart';
import 'package:wastedtalent/services/product/getProduct.dart';

import '../../services/chat/getMessages.dart';

class ExploreSearch extends StatefulWidget {
  final search;
  final imageSearch;

  const ExploreSearch({Key? key, this.search, this.imageSearch})
      : super(key: key);

  @override
  State<ExploreSearch> createState() => _ExploreSearchState();
}

class _ExploreSearchState extends State<ExploreSearch> {
  FirebaseAuth? _auth;
  List products = [];
  bool loading = true;

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
    if (widget.search == null) {
      loading = false;
    }
    /* var lproducts = await getAllProduct();
    print(lproducts);
    setState(() {
      products = lproducts;
    });*/
    var response = await http.post(Uri.parse(backendUrl + "/search"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'search': widget.search}));
    print(jsonDecode(response.body)['message']);

    setState(() {
      products = jsonDecode(response.body)['message'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white54,
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
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8, 0, 0),
                    child: Text(
                      widget.search == null
                          ? "Image Search"
                          : "Results for '" + widget.search + "':",
                      style: GoogleFonts.metrophobic(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.search == null ? 3 : products.length,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: InkWell(
                              onTap: () {
                                /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ViewProduct(
                                        section: "Product",
                                        uid: products[index][0]["uid"],
                                        id: products[index][1],
                                      )));
                        */
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
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(40),
                                            child: InkWell(
                                              onTap: () {
                                                showImageViewer(
                                                    context,
                                                    Image.asset(widget.search ==
                                                                null
                                                            ? 'data/wikiarts/wikiarts/' +
                                                                widget.imageSearch[
                                                                    index]
                                                            : products[index]
                                                                    ["content"]
                                                                .toString()
                                                                .substring(2))
                                                        .image,
                                                    swipeDismissible: false);
                                              },
                                              child: Image(
                                                  height: 64,
                                                  width: 64,
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(widget
                                                              .search ==
                                                          null
                                                      ? 'data/wikiarts/wikiarts/' +
                                                          widget.imageSearch[
                                                              index]
                                                      : products[index]
                                                              ["content"]
                                                          .toString()
                                                          .substring(2)
                                                          .toString())),
                                            ),
                                          )),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          //products[index][0]["title"],
                                          "Some title",
                                          style: GoogleFonts.metrophobic(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          //products[index][0]["description"],
                                          "Some description",
                                          style: GoogleFonts.metrophobic(),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
  }
}
