import 'package:flutter/material.dart';

class TabletScreenReciept extends StatefulWidget {
  const TabletScreenReciept({super.key});

  @override
  State<TabletScreenReciept> createState() => _TabletScreenRecieptState();
}

class _TabletScreenRecieptState extends State<TabletScreenReciept> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Reciept Tablet")),);
  }
}