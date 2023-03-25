import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wastedtalent/models/categories.dart';
import 'package:wastedtalent/services/learn/addWorkshop.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final nameController = TextEditingController();

  final linkController = TextEditingController();
  FirebaseAuth? auth;
  int selectedCategory = -1;
  int categoryIndex = 0;
  DateTime initialval = DateTime.now();
  DateTime mydate = DateTime.now();
  late TimeOfDay mytime;
  Marker loc = const Marker(markerId: MarkerId('marker'));

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    //_auth!.signOut();
    init_wrapper();
    // _user = _auth!.currentUser;
  }
  init_wrapper() async {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(resizeToAvoidBottomInset: false,
          body: NestedScrollView(
              headerSliverBuilder: (context, innerboxScrolled) => [
                SliverAppBar(foregroundColor: Colors.black,
                  expandedHeight: MediaQuery.of(context).size.height * 0.25,
                  flexibleSpace: FlexibleSpaceBar(title: Text('Add a workshop',style: GoogleFonts.metrophobic(color: Colors.black,fontWeight: FontWeight.bold),),
                    background: Image.network('https://images.pexels.com/photos/4145153/pexels-photo-4145153.jpeg?auto=compress&cs=tinysrgb&w=1200',fit: BoxFit.cover,),
                  ),
                ),
              ],
              body: Container(
                width: MediaQuery.of(context)
                    .size
                    .width -
                    32,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Material(
                  borderRadius:
                  BorderRadius.circular(12),
                  child: Column(
                    mainAxisSize:
                    MainAxisSize.min,
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets
                            .fromLTRB(

                            16.0,12,16,8),
                        child: TextField(
                          controller:
                          nameController,
                          style:
                          GoogleFonts.alata(
                              color: Colors
                                  .black),
                          decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(
                                  vertical:
                                  2,
                                  horizontal:
                                  16),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(
                                          0xff3F38DD))),
                              labelText:
                              "Name of the Workshop"
                                  ,
                              labelStyle:
                              GoogleFonts.alata(
                                  fontSize:
                                  14,
                                  color: Colors
                                      .black)),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets
                            .fromLTRB(

                            16.0,12,16,8),
                        child: TextField(
                          controller:
                          linkController,
                          style:
                          GoogleFonts.alata(
                              color: Colors
                                  .black),
                          decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(
                                  vertical:
                                  2,
                                  horizontal:
                                  16),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(
                                          0xff3F38DD))),
                              labelText:
                              "Link of the Workshop(If online)"
                              ,
                              labelStyle:
                              GoogleFonts.alata(
                                  fontSize:
                                  14,
                                  color: Colors
                                      .black)),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final todayDate =
                          DateTime.now();
                          final pickDate =
                          await showDatePicker(

                              context:
                              context,
                              initialDate:
                              todayDate,
                              firstDate:
                              todayDate,
                              builder: (BuildContext
                              context,
                                  Widget?
                                  child) {
                                return Theme(
                                  data: ThemeData
                                      .light()
                                      .copyWith(
                                    primaryColor:
                                    const Color(0xff3F38DD),
                                    accentColor:
                                    const Color(0xff3F38DD),
                                    colorScheme:
                                    ColorScheme.light(primary: const Color(0xff3F38DD)),
                                  ),
                                  child:
                                  child!,
                                );
                              },
                              lastDate: DateTime(
                                  todayDate
                                      .year +
                                      1));
                          if (pickDate !=
                              null) {
                            final pickTime =
                            await showTimePicker(
                                context:
                                context,
                                builder: (BuildContext
                                context,
                                    Widget?
                                    child) {
                                  return Theme(
                                    data: ThemeData.light()
                                        .copyWith(
                                      primaryColor:
                                      const Color(0xff3F38DD),
                                      accentColor:
                                      const Color(0xff3F38DD),
                                      colorScheme:
                                      ColorScheme.light(primary: const Color(0xff3F38DD)),
                                    ),
                                    child:
                                    child!,
                                  );
                                },
                                initialTime: const TimeOfDay(
                                    hour: 9,
                                    minute:
                                    0));
                            if (pickTime !=
                                null) {
                              setState(() {
                                mydate = DateTime(
                                    pickDate
                                        .year,
                                    pickDate
                                        .month,
                                    pickDate
                                        .day,
                                    pickTime
                                        .hour,
                                    pickTime
                                        .minute);
                              });
                            }
                          }
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets
                              .all(12.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(
                                        0xff3F38DD)
                                        .withOpacity(
                                        0.17),
                                    borderRadius:
                                    BorderRadius.circular(
                                        12)),
                                child: Padding(
                                  padding:
                                  const EdgeInsets
                                      .all(
                                      8.0),
                                  child: Icon(
                                    Icons
                                        .calendar_today,
                                    color: Color(
                                        0xff3F38DD),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets
                                    .only(
                                    left:
                                    8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Text(
                                      "${mydate.day} ${DateFormat('MMMM').format(mydate)}, ${mydate.year}",
                                      style: GoogleFonts.alata(
                                          fontSize:
                                          14),
                                    ),
                                    Text(
                                        "${DateFormat('EEEE').format(mydate)}," +
                                            DateFormat('h:mm a').format(
                                                mydate),
                                        style: GoogleFonts.alata(
                                            color:
                                            Color(0xff767676),
                                            fontSize: 14))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets
                            .all(12.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              categoryIndex =
                                  (categoryIndex +
                                      1) %
                                      category
                                          .length;
                              print(
                                  categoryIndex);
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(
                                        0xff3F38DD)
                                        .withOpacity(
                                        0.17),
                                    borderRadius:
                                    BorderRadius.circular(
                                        12)),
                                child:
                                const Padding(
                                  padding:
                                  EdgeInsets
                                      .all(
                                      8.0),
                                  child: Icon(
                                    Icons
                                        .category,
                                    color: Color(
                                        0xff3F38DD),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets
                                    .only(
                                    left:
                                    8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Text(
                                      "Category"
                                          ,
                                      style: GoogleFonts.alata(
                                          fontSize:
                                          14),
                                    ),
                                    Text(
                                        category[categoryIndex]
                                            .toString()
                                            ,
                                        style: GoogleFonts.alata(
                                            color:
                                            Color(0xff767676),
                                            fontSize: 14))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Select a Location"
                          ,
                          style: GoogleFonts.alata(
                              fontSize:
                              14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 192,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(12.934695, 77.601991),
                              zoom: 11.5,
                            ),
                            markers: {loc},
                            onLongPress: addMarker,
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            await addWorkshop(auth?.currentUser?.uid, nameController.text,category[categoryIndex], "${mydate.day} ${DateFormat('MMMM').format(mydate)}, ${mydate.year}"+'|'+"${DateFormat('EEEE').format(mydate)}," +
                                DateFormat('h:mm a').format(
                                    mydate), loc.position.latitude.toString() +
                                ',' +
                                loc.position.longitude.toString(),linkController.text);
                            Navigator.pop(context);
                            },
                          child: Container(
                            width: MediaQuery.of(
                                context)
                                .size
                                .width -
                                48,
                            decoration: BoxDecoration(
                                color: Color(
                                    0xff5A68F6),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    12)),
                            child: Padding(
                              padding:
                              const EdgeInsets
                                  .all(8.0),
                              child: Text(
                                "Add",
                                textAlign:
                                TextAlign
                                    .center,
                                style: GoogleFonts.alata(
                                    color: Colors
                                        .white,
                                    fontSize:
                                    16),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              )),
        ));
  }
  void addMarker(LatLng argument) {
    setState(() {
      loc = Marker(markerId: MarkerId('marker'), position: argument);
    });
  }
}
