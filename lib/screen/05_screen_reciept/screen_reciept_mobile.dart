import 'package:flutter/material.dart';

class MobileScreenReciept extends StatefulWidget {
  const MobileScreenReciept({super.key});

  @override
  State<MobileScreenReciept> createState() => _MobileScreenRecieptState();
}

class _MobileScreenRecieptState extends State<MobileScreenReciept> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Reciept Mobile")),);
  }
}