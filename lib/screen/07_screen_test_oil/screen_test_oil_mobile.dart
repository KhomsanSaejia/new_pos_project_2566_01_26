import 'package:flutter/material.dart';

class MobileScreenTestOil extends StatefulWidget {
  const MobileScreenTestOil({super.key});

  @override
  State<MobileScreenTestOil> createState() => _MobileScreenTestOilState();
}

class _MobileScreenTestOilState extends State<MobileScreenTestOil> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Test Oil Mobile")),);
  }
}