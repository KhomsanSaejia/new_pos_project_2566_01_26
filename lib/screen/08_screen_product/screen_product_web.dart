import 'package:flutter/material.dart';

class WebScreenProduct extends StatefulWidget {
  const WebScreenProduct({super.key});

  @override
  State<WebScreenProduct> createState() => _WebScreenProductState();
}

class _WebScreenProductState extends State<WebScreenProduct> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("WebScreenProduct")),);
  }
}