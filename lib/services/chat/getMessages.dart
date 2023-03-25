



import 'package:firebase_database/firebase_database.dart';

getMessages(x,uid) async {
  print(x);
  final snapshot = await FirebaseDatabase.instance.ref('chat/'+x).get();
  if(snapshot.exists){
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    List messages = [];
    for(int i=0;i<data.keys.length;i++){
      var message = data[data.keys.toList()[i]];
      messages.add({"messageType":message['uid']==uid?"sender":"receiver","messageContent":message['message']});
    }
    return messages;
  }
else{
  return [];
  }
}