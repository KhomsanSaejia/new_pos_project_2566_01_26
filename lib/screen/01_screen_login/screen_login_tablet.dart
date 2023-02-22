// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:new_pos_project_2566_01_26/database/database.dart';
import '../../utility/style.dart';

class TabletScreenLogin extends StatefulWidget {
  const TabletScreenLogin({super.key});

  @override
  State<TabletScreenLogin> createState() => _TabletScreenLoginState();
}

class _TabletScreenLoginState extends State<TabletScreenLogin> {
  TextEditingController tbUsername = TextEditingController();
  TextEditingController tbPassworde = TextEditingController();

  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/image/texture-background.jpg")),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                row1(),
                row2(),
                MyObject().textVersion(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget row1() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyObject().textShowLogin(context),
            MyObject().logo(context)
          ],
        ),
      ),
    );
  }

  Widget row2() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            txtUsername(),
            txtPassword(),
            buttonLogin(),
          ],
        ),
      ),
    );
  }

  Widget txtUsername() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(171, 171, 171, .7),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: TextField(
          style: const TextStyle(
              color: Colors.black, fontFamily: "Sarabun", fontSize: 30),
          controller: tbUsername,
          obscureText: false,
          onChanged: (value) => username = value.trim(),
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.person_rounded),
            hintText: "ชื่อผู้ใช้งาน",
            hintStyle: TextStyle(
                color: Colors.grey, fontFamily: "Sarabun", fontSize: 30),
          ),
        ),
      ),
    );
  }

  Widget txtPassword() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(171, 171, 171, .7),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: TextField(
          style: const TextStyle(
              color: Colors.black, fontFamily: "Sarabun", fontSize: 30),
          controller: tbPassworde,
          obscureText: true,
          onChanged: (value) => password = value.trim(),
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.password),
            hintText: "รหัสผ่าน",
            hintStyle: TextStyle(
                color: Colors.grey, fontFamily: "Sarabun", fontSize: 30),
          ),
        ),
      ),
    );
  }

  Widget buttonLogin() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade800,
          elevation: 10,
          fixedSize: Size(MediaQuery.of(context).size.width * 0.5,
              MediaQuery.of(context).size.height * 0.1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () async {
          print("username : $username");
          print("password : $password");

          Database().databslogin(username!);
        },
        child: const Text(
          "เข้าสู่ระบบ",
          style: TextStyle(fontFamily: "Sarabun", fontSize: 30),
        ),
      ),
    );
  }
}
