import 'package:flutter/material.dart';

import '../../model/model_user.dart';

class WebScreenSale extends StatefulWidget {
  final ModelUser modelUser;
  const WebScreenSale({super.key, required this.modelUser});

  @override
  State<WebScreenSale> createState() => _WebScreenSaleState();
}

class _WebScreenSaleState extends State<WebScreenSale> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Sale Web")),);
  }
}