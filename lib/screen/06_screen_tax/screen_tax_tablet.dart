import 'package:flutter/material.dart';

class TabletScreenTax extends StatefulWidget {
  const TabletScreenTax({super.key});

  @override
  State<TabletScreenTax> createState() => _TabletScreenTaxState();
}

class _TabletScreenTaxState extends State<TabletScreenTax> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Tax Tablet")),);
  }
}