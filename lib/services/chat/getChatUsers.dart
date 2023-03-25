




import 'package:firebase_database/firebase_database.dart';
import 'package:wastedtalent/services/getUserInfo.dart';

getChatUsers(uid) async{
  final snapshot=await FirebaseDatabase.instance.ref('chat/').get();
  if(snapshot.exists){
    var listofuids = [];
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    var key = data.keys.toList();
    for(int i=0;i<key.length;i++){
      if(key[i].split('wastedTalent')[0]==uid){
        var userData =await getUserInfo(key[i].split('wastedTalent')[1]);
        listofuids.add([userData,key[i].split('wastedTalent')[1]]);
      }
      if(key[i].split('wastedTalent')[1]==uid){
        var userData =await getUserInfo(key[i].split('wastedTalent')[0]);
        listofuids.add([userData,key[i].split('wastedTalent')[0]]);
      }
    }
    return listofuids;
  }
  return [];
}