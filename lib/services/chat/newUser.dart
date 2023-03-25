


import 'package:firebase_database/firebase_database.dart';

newUser(uid1,uid2)async{
  DatabaseReference ref1=FirebaseDatabase.instance.ref('chat/'+uid1+'wastedTalent'+uid2);
  DatabaseReference ref2=FirebaseDatabase.instance.ref('chat/'+uid2+'wastedTalent'+uid1);
  final snapshot1 = await ref1.get();
  final snapshot2 = await ref2.get();
  if(snapshot1.exists){
    return uid1+'wastedTalent'+uid2;
  }
  else if(snapshot2.exists){
    return uid2+'wastedTalent'+uid1;
  }
  else{
    return uid1+'wastedTalent'+uid2;
  }
}