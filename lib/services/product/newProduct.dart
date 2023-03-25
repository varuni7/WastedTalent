


import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';

newProduct(uid,title,description,tags,qty,price,List<File> files) async {
  var loc = await Location().getLocation();
  String latlong =
      loc.latitude.toString() + ',' + loc.longitude.toString();

  DatabaseReference ref =
  FirebaseDatabase.instance.ref('products/').push();
  List<String> _downloadUrls = [];
int i=0;
  await Future.forEach(files, (image) async {
    print(ref.key);
    Reference ref2 = FirebaseStorage.instance
        .ref()
        .child('products/'+ref.key!)
        .child(i.toString());
    final UploadTask uploadTask = ref2.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final url = await taskSnapshot.ref.getDownloadURL();
    i++;
    _downloadUrls.add(url);
  });

  ref.set({
    'title': title,
    'description': description,
    'tags': tags,
    'quantity': qty,
    'price': price,
    'imgURL':json.encode(_downloadUrls) ,
    'uid':uid,
    'createdAt':DateTime.now().toString(),
    'location': latlong
  });

}
