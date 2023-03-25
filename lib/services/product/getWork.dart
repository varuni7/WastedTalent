


import 'package:firebase_database/firebase_database.dart';

getWork(uid)async{
  print("getWork");
  print(uid);
  final snapshot = await FirebaseDatabase.instance.ref('users/'+uid+'/work').get();
  if(snapshot.exists){
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    var finalData=[];
    for(int i=0;i<data.keys.toList().length;i++){
      finalData.add([data[data.keys.toList()[i]],data.keys.toList()[i]]);
    }
    return finalData;
  }
else{
  return [];
  }
}



getWorkByID(uid,id)async{
  final snapshot = await FirebaseDatabase.instance.ref('users/'+uid+'/work/'+id).get();
  var data = Map<String, dynamic>.from(snapshot.value as dynamic);
  return data;
}