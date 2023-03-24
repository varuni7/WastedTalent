import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  var messages = [{"messageType":"receiver","messageContent":"Hello"},{"messageType":"sender","messageContent":"Hi"}];
  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/5.jpg"),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Nigel Dias",style: GoogleFonts.metrophobic( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 3,),
                      Text("Online",style: GoogleFonts.metrophobic(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),
                Icon(Icons.delete,color: Colors.black54,),
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
          child: TextField(
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
        IconButton(onPressed: (){}, icon: Icon(Icons.send)),
      ],)
    ],),
    );
  }
}
