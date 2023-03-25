import 'package:flutter/material.dart';
import 'package:wastedtalent/widgets/bottom_app_nav.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(bottomNavigationBar: BottomAppNav(index: 2,),);
  }
}
