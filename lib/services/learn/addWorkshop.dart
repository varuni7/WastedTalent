


import 'package:firebase_database/firebase_database.dart';

addWorkshop(uid,name,category,datetime,loc,link){
  final ref = FirebaseDatabase.instance.ref('events/').push();
  ref.set({
    "uid":uid,
    "category":category,
    "location":loc,"link":link,
    "dateTime":datetime,
      "name":name,
    "createdAt":DateTime.now().millisecondsSinceEpoch
  });
}