


import 'package:firebase_database/firebase_database.dart';

getProduct(uid)async{
  final snapshot = await FirebaseDatabase.instance.ref('products').get();
  var data = Map<String, dynamic>.from(snapshot.value as dynamic);
  var finalData=[];
  for(int i=0;i<data.keys.toList().length;i++){
    data[data.keys.toList()[i]]['uid']==uid?finalData.add([data[data.keys.toList()[i]],data.keys.toList()[i]]):finalData;
  }
  return finalData;
}

getProductByID(id)async{
  final snapshot = await FirebaseDatabase.instance.ref('products/'+id).get();
  var data = Map<String, dynamic>.from(snapshot.value as dynamic);
  return data;
}


getAllProduct()async{
  final snapshot = await FirebaseDatabase.instance.ref('products').get();
  var data = Map<String, dynamic>.from(snapshot.value as dynamic);
  var finalData=[];
  for(int i=0;i<data.keys.toList().length;i++){
    finalData.add([data[data.keys.toList()[i]],data.keys.toList()[i]]);
  }
  return finalData;

}