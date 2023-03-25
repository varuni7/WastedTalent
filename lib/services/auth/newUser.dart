

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';

newUser(name,age,files,uid)async {
  var loc = await Location().getLocation();
  DatabaseReference ref1 = FirebaseDatabase.instance.ref();
     if (name != '' &&
          age != '' &&
          files != null) {
        DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/' + uid);
        String latlong =
            loc.latitude.toString() + ',' + loc.longitude.toString();
        ref.set({
          'name': name,
          'story': age,
          'location': latlong
        });
        FirebaseStorage.instance
            .ref('users/' + uid + '/profile')
            .putFile(files!);

      }


}


