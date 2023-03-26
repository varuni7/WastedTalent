



import 'package:firebase_database/firebase_database.dart';

getNotifications(uid) async{
  final snapshot =await FirebaseDatabase.instance.ref('users/'+uid+"/notifications").get();
  if(snapshot.exists){
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    var ldata = [];
    for(int i=0;i<data.keys.length;i++){
      ldata.add(data[data.keys.toList()[i]]);
    }
    ldata.sort((a, b) => (b['createdAt']).compareTo(a['createdAt']));

      ldata = ldata.reversed.toList();
    return ldata;
  }
  else{
    return [];
  }
}