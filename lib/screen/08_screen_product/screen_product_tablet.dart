import 'package:flutter/material.dart';

class TabletScreenProduct extends StatefulWidget {
  const TabletScreenProduct({super.key});

  @override
  State<TabletScreenProduct> createState() => _TabletScreenProductState();
}

class _TabletScreenProductState extends State<TabletScreenProduct> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("TabletScreenProduct")),);
  }
}