import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_pos_project_2566_01_26/screen/01_screen_login/screen_login.dart';



void main() async {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      title: 'Pump Smart Pos',
      
      home: const ScreenLogin(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: true,
    );
  }
}
