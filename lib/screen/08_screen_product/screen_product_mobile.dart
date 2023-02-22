import 'package:flutter/material.dart';

class MobileScreenProduct extends StatefulWidget {
  const MobileScreenProduct({super.key});

  @override
  State<MobileScreenProduct> createState() => _MobileScreenProductState();
}

class _MobileScreenProductState extends State<MobileScreenProduct> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("MobileScreenProduct")),);
  }
}