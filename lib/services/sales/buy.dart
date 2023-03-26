



import 'package:firebase_database/firebase_database.dart';

buy(uid,qty,customer_uid,product_uid){
print(uid);
print(qty);
print(customer_uid);
print(product_uid);
  DatabaseReference ref =
  FirebaseDatabase.instance.ref('users/'+uid+'/active_orders').push();
  ref.set({
    "productuid":product_uid,
    "customeruid":customer_uid,
    "Quantity":qty,
    "createdAt":DateTime.now().millisecondsSinceEpoch
  });
}