





import 'package:firebase_database/firebase_database.dart';

getWorkshops()async{
  final snapshot = await FirebaseDatabase.instance.ref('events').get();
  var data = Map<String, dynamic>.from(snapshot.value as dynamic);
  var finalData=[];
  for(int i=0;i<data.keys.toList().length;i++){
    finalData.add(data[data.keys.toList()[i]]);
  }
  return finalData;

}