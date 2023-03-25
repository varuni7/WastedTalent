



import 'package:firebase_database/firebase_database.dart';

buy(uid,qty,customer_uid){

  DatabaseReference ref =
  FirebaseDatabase.instance.ref('users/'+uid+'/active_orders').push();
  ref.set({});
}