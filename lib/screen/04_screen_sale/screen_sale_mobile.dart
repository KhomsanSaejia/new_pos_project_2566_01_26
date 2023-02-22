import 'package:flutter/material.dart';

class MobileScreenSale extends StatefulWidget {
  const MobileScreenSale({super.key});

  @override
  State<MobileScreenSale> createState() => _MobileScreenSaleState();
}

class _MobileScreenSaleState extends State<MobileScreenSale> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Sale Mobile")),);
  }
}