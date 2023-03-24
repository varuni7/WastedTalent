import 'package:flutter/material.dart';
import 'package:wastedtalent/widgets/bottom_app_nav.dart';

/*class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var story = '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''';
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
      child: SafeArea(
        child: Scaffold(bottomNavigationBar: BottomAppNav(index: 3,),body: Column(children: [
          Row(children: [
            Expanded(child: CircleAvatar(radius: 64,backgroundImage: NetworkImage("https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80"),)),
            Expanded(
              child: Column(
                children: [
                  Text('Shetty Arts and Crafts'),
                ],
              ),
            )
          ],),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(highlightColor: Colors.transparent,splashColor: Colors.transparent,onTap: (){
              setState(() {
                expand=expand?false:true;
              });
            },child: Text(expand?story:story.substring(0,120)+"...")),
          ),
          Row(children: [
            Expanded(
              child: TextButton(onPressed: (){}, child: Container(
                child: Text("Chat"),
              )),
            ),
            Expanded(
              child: TextButton(onPressed: (){}, child: Container(
                child: Text("Show on map"),
              )),
            ),
          ],),
          AppBar(bottom: TabBar(tabs: [Tab(icon: Icon(Icons.money),),Tab(icon: Icon(Icons.work),)],),),
          Expanded(child: TabBarView(children: [
            Container(child: Text('Money'),),
            Container(child: Text("Work"),)
          ],))
        ],),),
      ),
    );
  }
}
*/

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  var story = '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''';
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomAppNav(index: 3,),
        body: Column(
          children: <Widget>[
            // construct the profile details widget here
            Row(children: [
              Expanded(child: CircleAvatar(radius: 64,backgroundImage: NetworkImage("https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80"),)),
              Expanded(
                child: Column(
                  children: [
                    Text('Shetty Arts and Crafts'),
                  ],
                ),
              )
            ],),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(highlightColor: Colors.transparent,splashColor: Colors.transparent,onTap: (){
                setState(() {
                  expand=expand?false:true;
                });
              },child: Text(expand?story:story.substring(0,120)+"...")),
            ),
            Row(children: [
              Expanded(
                child: TextButton(onPressed: (){}, child: Container(
                  child: Text("Chat"),
                )),
              ),
              Expanded(
                child: TextButton(onPressed: (){}, child: Container(
                  child: Text("Show on map"),
                )),
              ),
            ],),
            // the tab bar with two items
            SizedBox(
              height: 75,
              child: AppBar(
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.directions_bike),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.directions_car,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Container(
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'Bike',
                      ),
                    ),
                  ),

                  // second tab bar viiew widget
                  Container(
                    color: Colors.pink,
                    child: Center(
                      child: Text(
                        'Car',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}