


import 'package:firebase_database/firebase_database.dart';

sendMessage(x,content,uid)async{
  print("Sending...");
  print(x);
  final ref = FirebaseDatabase.instance.ref('chat/'+x+"/").push();
  ref.set({
    "uid":uid,
    "message":content,
    "createdAt":DateTime.now().millisecondsSinceEpoch
  });
}