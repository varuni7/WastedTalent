




import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

getUserInfo(uid) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/'+uid);
  final snapshot = await ref.get();
  if (snapshot.exists) {
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    var imgurl = await FirebaseStorage.instance
        .ref('users/' + uid + '/profile').getDownloadURL();
    return [data,imgurl];
  }
}