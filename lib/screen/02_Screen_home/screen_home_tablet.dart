import 'package:flutter/material.dart';

import '../../model/model_user.dart';

class TabletScreenHome extends StatefulWidget {
  final ModelUser modelUser;
  const TabletScreenHome({super.key, required this.modelUser});

  @override
  State<TabletScreenHome> createState() => _TabletScreenHomeState();
}

class _TabletScreenHomeState extends State<TabletScreenHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(child: Text("TabletScreenHome ${widget.modelUser.respMsg!.userFirstname}")),);
  }
}