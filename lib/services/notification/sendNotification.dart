




import 'package:firebase_database/firebase_database.dart';

sendNotification(uid,name,message,like) async{
  final ref = FirebaseDatabase.instance.ref('users/'+uid+"/notifications").push();
  ref.set({
    "uid":uid,
    "message":like==0?"You have received one message from:"+name+":'"+message+"'":name+" has liked your "+message,
    "createdAt":DateTime.now().millisecondsSinceEpoch
  });
}