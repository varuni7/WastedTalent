




import 'package:calc_lat_long/UnitLengthEnum.dart';
import 'package:calc_lat_long/calc_lat_long.dart';
import 'package:firebase_database/firebase_database.dart';

import 'getUserInfo.dart';

recommendLocalShops(uid) async{
  UnitLength _selectedUnit = UnitLength.km;
  final snapshot=await FirebaseDatabase.instance.ref('users/').get();
  if(snapshot.exists){
    var listofuids = [];
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    var key = data.keys.toList();
    var loc = data[uid]['location'];
    print(key);
    for(int i=0;i<key.length;i++){
      print(key[i]);
      String loc2 = data[key[i]]['location'];
      print(loc2);
      var dist = CalcDistance.distance(
          double.parse(loc.split(',')[0]),
          double.parse(loc.split(',')[1]),
          double.parse(loc2.split(',')[0]),
          double.parse(loc2.split(',')[1]),
          _selectedUnit);
      print(dist);
      if(dist<=11000 && uid !=key[i]){
        var userData =await getUserInfo(key[i]);
        listofuids.add([userData,key[i]]);
      }
    }
    return listofuids;
  }
  return [];
}