import 'package:flutter/material.dart';

class WebScreenUser extends StatefulWidget {
  const WebScreenUser({super.key});

  @override
  State<WebScreenUser> createState() => _WebScreenUserState();
}

class _WebScreenUserState extends State<WebScreenUser> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("WebScreenUser")),);
  }
}