import 'package:flutter/material.dart';

class MobileScreenUser extends StatefulWidget {
  const MobileScreenUser({super.key});

  @override
  State<MobileScreenUser> createState() => _MobileScreenUserState();
}

class _MobileScreenUserState extends State<MobileScreenUser> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("MobileScreenUser")),);
  }
}