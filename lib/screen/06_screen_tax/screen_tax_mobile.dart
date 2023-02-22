import 'package:flutter/material.dart';

class MobileScreenTax extends StatefulWidget {
  const MobileScreenTax({super.key});

  @override
  State<MobileScreenTax> createState() => _MobileScreenTaxState();
}

class _MobileScreenTaxState extends State<MobileScreenTax> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Tax Mobile")),);
  }
}