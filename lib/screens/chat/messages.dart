import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastedtalent/services/chat/newUser.dart';

import '../../services/chat/getMessages.dart';
import '../../services/chat/sendMessage.dart';

class Messages extends StatefulWidget {
  final url;
  final uid;
  final name;
  const Messages({Key? key,this.name,this.uid,this.url}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late StreamSubscription stream;
  List messages = [];
  String id="";
  final messageController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    //_auth!.signOut();
    init_wrapper();
    // _user = _auth!.currentUser;
  }

  init_wrapper() async {
    print("this is running");
    print(widget.url);
    String x =await newUser(widget.uid, _auth.currentUser?.uid);
    var lmessages = [];
    stream =
        FirebaseDatabase.instance.ref('chat/'+x).onValue.listen((event) async {
          var data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
          messages = [];
          print("Data");
          print(data);
          for(int i=0;i<data.keys.length;i++){
            var message = data[data.keys.toList()[i]];
            messages.add({"messageType":message['uid']==_auth.currentUser?.uid?"sender":"receiver","messageContent":message['message'],"createdAt":message['createdAt']});
          }
          messages.sort((a, b) => (b['createdAt']).compareTo(a['createdAt']));
          setState(() {
            messages = messages.reversed.toList();
          });
        });

    setState(() {
      id=x;
      messages = messages;
    });
  }
  @override
  Widget build(BuildContext context) {
    print("Id");
    print(messages);
    return Scaffold(resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.url),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.name,style: GoogleFonts.metrophobic( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 3,),
                      Text("Online",style: GoogleFonts.metrophobic(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),
                IconButton(onPressed: () async {
                  await FirebaseDatabase.instance.ref('chat/'+id).remove();
                  Navigator.pop(context);
                },icon: Icon(Icons.delete,color: Colors.black54,)),
              ],
            ),
          ),
        ),
      ),body: Column(children: [
      SizedBox(height: MediaQuery.of(context).size.height-138,
        child: ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10,bottom: 10),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return Container(
              padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
              child: Align(
                alignment: (messages[index]['messageType'] == "receiver"?Alignment.topLeft:Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (messages[index]['messageType']  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(messages[index]['messageContent']!, style: TextStyle(fontSize: 15),),
                ),
              ),
            );
          },
        ),
      ),
      Row(children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.add)),
        Expanded(
          child: TextField(controller: messageController,
            decoration: InputDecoration(
              hintText: "Send a message",
              hintStyle: TextStyle(color: Colors.grey.shade600),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.grey.shade100
                  )
              ),
            ),
          ),
        ),
        IconButton(onPressed: (){
          print("Id");
          print(id);
          sendMessage(id,messageController.text,_auth.currentUser?.uid);
        }, icon: Icon(Icons.send)),
      ],)
    ],),
    );
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    stream.cancel();
    super.deactivate();
  }
}
