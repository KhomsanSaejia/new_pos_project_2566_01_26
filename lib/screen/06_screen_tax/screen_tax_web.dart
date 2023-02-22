import 'package:flutter/material.dart';

class WebScreenTax extends StatefulWidget {
  const WebScreenTax({super.key});

  @override
  State<WebScreenTax> createState() => _WebScreenTaxState();
}

class _WebScreenTaxState extends State<WebScreenTax> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Tax Web")),);
  }
}