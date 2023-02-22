import 'package:flutter/material.dart';

import '../../model/model_user.dart';

class MobileScreenHome extends StatefulWidget {
  final ModelUser modelUser;
  const MobileScreenHome({super.key, required this.modelUser});

  @override
  State<MobileScreenHome> createState() => _MobileScreenHomeState();
}

class _MobileScreenHomeState extends State<MobileScreenHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child: Text(
              "MobileScreenHome ${widget.modelUser.respMsg!.userFirstname}")),
    );
  }
}
