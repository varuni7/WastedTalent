import 'package:flutter/material.dart';

import '../utils/bottom_app_navigation.dart';

class BottomAppNav extends StatefulWidget {
  final index;
  const BottomAppNav({Key? key,this.index}) : super(key: key);

  @override
  State<BottomAppNav> createState() => _BottomAppNavState();
}

class _BottomAppNavState extends State<BottomAppNav> {
  var activeColor = Color(0xffC19280);
  var color  = Color(0xffF5D3AD);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.index,
        onTap: (int index) {
          bottom_navigation(index, context);
        },
        items:  [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
                color: widget.index==0?activeColor:color,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: widget.index==1?activeColor:color,
              ),
              label: " "),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.auto_graph,
                color: widget.index==2?activeColor:color,
              ),
              label: " "),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.perm_identity,
                color: widget.index==3?activeColor:color,
              ),
              label: " "),
        ]);
  }
}
