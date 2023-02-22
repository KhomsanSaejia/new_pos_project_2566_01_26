// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_pos_project_2566_01_26/api/api.dart';
import 'package:new_pos_project_2566_01_26/screen/02_Screen_home/screen_home_web.dart';
import '../../model/model_user.dart';
import '../../utility/style.dart';

class WebScreenLogin extends StatefulWidget {
  const WebScreenLogin({super.key});

  @override
  State<WebScreenLogin> createState() => _WebScreenLoginState();
}

class _WebScreenLoginState extends State<WebScreenLogin> {
  TextEditingController tbUsername = TextEditingController();
  TextEditingController tbPassworde = TextEditingController();

  String? username, password;
  bool boolPassword = true;
  Icon defaulIcon = const Icon(Icons.lock_outline);
  Color defaulIconColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                // Color.fromARGB(255, 0, 123, 255),
                Color.fromARGB(255, 131, 190, 255),
                Color.fromARGB(255, 80, 164, 255),
                // Color.fromARGB(255, 131, 190, 255),
              ],
            ),
          ),
          child: Column(
            children: [
              // MyObject().textShowLogin(context),
              MyObject().logo(context),
              MyObject().textShowLogin(context),
              // row1(),
              row2(),
              MyObject().textVersion(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget row1() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.2,
        color: Colors.red,
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
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            txtUsername(),
            txtPassword(),
            buttonLogin(context),
          ],
        ),
      ),
    );
  }

  Widget txtUsername() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.05,
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
          style: GoogleFonts.sarabun(color: Colors.black),
          controller: tbUsername,
          obscureText: false,
          onChanged: (value) => username = value.trim(),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.person_rounded),
            hintText: "ชื่อผู้ใช้งาน",
            hintStyle: GoogleFonts.sarabun(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget txtPassword() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.05,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: TextField(
                style: GoogleFonts.sarabun(color: Colors.black),
                controller: tbPassworde,
                obscureText: boolPassword,
                onChanged: (value) => password = value.trim(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.password),
                  hintText: "รหัสผ่าน",
                  hintStyle: GoogleFonts.sarabun(color: Colors.grey),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (boolPassword == true) {
                    boolPassword = false;
                    defaulIcon = const Icon(Icons.lock_open_outlined);
                    defaulIconColor = Colors.red;
                  } else {
                    boolPassword = true;
                    defaulIcon = const Icon(Icons.lock_outline);
                    defaulIconColor = Colors.green;
                  }
                });
              },
              icon: defaulIcon,
              color: defaulIconColor,
            )
          ],
        ),
      ),
    );
  }

  Widget buttonLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // backgroundColor: Colors.green,
          backgroundColor: const Color(0xFF007BFF),
          elevation: 10,
          fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
              MediaQuery.of(context).size.height * 0.05),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () async {
          EasyLoading.show(status: 'loading...');
          String respUser = await API().login(username!, password!);
          if (respUser == "null") {
            EasyLoading.showError('ไม่สามารถเข้าสู่ระบบได้');
          } else {
            try {
              ModelUser modelUser = ModelUser.fromJson(jsonDecode(respUser));

              if (modelUser.respMsg!.userPassword == MyObject().passwordhash(password!)) {
                EasyLoading.dismiss();
                MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                  return WebScreenHomepage(modelUser: modelUser);
                });
                EasyLoading.dismiss();
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
                
              } else {
                EasyLoading.showError('ชื่อผู้ใช้งาน หรือ รหัสผ่าน ไม่ถูกต้อง');
              }
            } catch (e) {
              print(e);
              EasyLoading.showError('ชื่อผู้ใช้งาน หรือ รหัสผ่าน ไม่ถูกต้อง');
            }
          }
        },
        child: Text(
          "เข้าสู่ระบบ",
          style: GoogleFonts.sarabun(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
