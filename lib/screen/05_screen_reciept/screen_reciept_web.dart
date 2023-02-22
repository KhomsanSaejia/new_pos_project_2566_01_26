import 'package:flutter/material.dart';

class WebScreenReciept extends StatefulWidget {
  const WebScreenReciept({super.key});

  @override
  State<WebScreenReciept> createState() => _WebScreenRecieptState();
}

class _WebScreenRecieptState extends State<WebScreenReciept> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Reciept Web")),);
  }
}