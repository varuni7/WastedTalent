import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final nameController = TextEditingController();
  FirebaseAuth? auth;
  List categories = ['events', 'voice_channel', 'reminder'];
  bool notified = true;
  int selectedCategory = -1;
  int categoryIndex = 0;
  List allEvents = [];
  DateTime initialval = DateTime.now();
  DateTime mydate = DateTime.now();
  late TimeOfDay mytime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (context, innerboxScrolled) => [
                SliverAppBar(foregroundColor: Colors.black,
                  expandedHeight: MediaQuery.of(context).size.height * 0.25,
                  flexibleSpace: FlexibleSpaceBar(title: Text('Add an event',style: GoogleFonts.metrophobic(color: Colors.black,fontWeight: FontWeight.bold),),
                    background: Image.network('https://images.pexels.com/photos/4145153/pexels-photo-4145153.jpeg?auto=compress&cs=tinysrgb&w=1200',fit: BoxFit.cover,),
                  ),
                ),
              ],
              body: Center(
                child: Container(
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
                              .symmetric(
                              horizontal:
                              16.0),
                          child: TextField(
                            controller:
                            nameController,
                            style:
                            GoogleFonts.alata(
                                color: Colors
                                    .black),
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(
                                    vertical:
                                    2,
                                    horizontal:
                                    16),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(
                                            0xff3F38DD))),
                                labelText:
                                "name_of_the_reminder"
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
                                        categories
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
                                        "category"
                                            ,
                                        style: GoogleFonts.alata(
                                            fontSize:
                                            14),
                                      ),
                                      Text(
                                          categories[categoryIndex]
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
                          padding:
                          const EdgeInsets
                              .all(12.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (notified ==
                                    false) {
                                  notified = true;
                                } else {
                                  notified =
                                  false;
                                }
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
                                          .notifications,
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
                                        "get_notified"
                                            ,
                                        style: GoogleFonts.alata(
                                            fontSize:
                                            14),
                                      ),
                                      Text(
                                          notified
                                              ? "yes"

                                              : 'no'
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
                        TextButton(
                            onPressed: () {
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
                ),
              )),
        ));
  }
}
