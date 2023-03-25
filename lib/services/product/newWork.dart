


import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';

newWork(uid,title,description,tags,List<File> files) async {
  var loc = await Location().getLocation();
  String latlong =
      loc.latitude.toString() + ',' + loc.longitude.toString();

  DatabaseReference ref =
  FirebaseDatabase.instance.ref('users/'+uid+'/work').push();
  List<String> _downloadUrls = [];
  int i=0;
  await Future.forEach(files, (image) async {
    print(ref.key);
    Reference ref2 = FirebaseStorage.instance
        .ref()
        .child('work/'+ref.key!)
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
    'imgURL':json.encode(_downloadUrls) ,
    'createdAt':DateTime.now().toString(),
    'location': latlong,
    "uid":uid
  });

}
