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
    return SafeArea(
        child: Scaffold(
      body: fullscreen(context),
    ));
  }

  Widget fullscreen(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          rowHead(),
        ],
      ),
    );
  }

  Widget rowHead() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.13,
      color: Colors.green,
      child: Row(children: [
        customCard(),
      ]),
    );
  }

  Widget customCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6c757d),
              Color(0xFF424949),
            ],
          ),
        ),
      ),
    );
  }
}
