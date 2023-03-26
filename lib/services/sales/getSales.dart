




import 'package:firebase_database/firebase_database.dart';

getSales(uid) async {
  final snapshot = await FirebaseDatabase.instance.ref('users/'+uid+"/active_orders").get();
  if(snapshot.exists){
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    var messages = [];
    for(int i=0;i<data.keys.length;i++){
      var message = data[data.keys.toList()[i]];
      messages.add(message);
    }
    return messages;
  }
  else{
    return [];
  }
}