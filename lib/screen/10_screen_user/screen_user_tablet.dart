import 'package:flutter/material.dart';

class TabletScreenUser extends StatefulWidget {
  const TabletScreenUser({super.key});

  @override
  State<TabletScreenUser> createState() => _TabletScreenUserState();
}

class _TabletScreenUserState extends State<TabletScreenUser> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("TabletScreenUser")),);
  }
}