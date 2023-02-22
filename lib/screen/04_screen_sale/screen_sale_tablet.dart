import 'package:flutter/material.dart';

class TabletScreenSale extends StatefulWidget {
  const TabletScreenSale({super.key});

  @override
  State<TabletScreenSale> createState() => _TabletScreenSaleState();
}

class _TabletScreenSaleState extends State<TabletScreenSale> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Sale Tablet")),);
  }
}