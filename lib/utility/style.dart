import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screen/01_screen_login/screen_login.dart';

class MyObject {
  Widget logo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage("assets/image/logo.png"),
          ),
        ),
      ),
    );
  }

  Widget textShowLogin(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "ยินดีต้อนรับ",
            style: GoogleFonts.sarabun(
              color: Colors.white,
              fontSize: 50,
            ),
          ),
          Text(
            "กรุณาเข้าสู่ระบบ",
            style: GoogleFonts.sarabun(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          // Text("ยินดีต้อนรับ",
          //     style: TextStyle(
          //         color: Colors.white, fontSize: 50, fontFamily: 'Sarabun')),
          // Text("กรุณาเข้าสู่ระบบ",
          //     style: TextStyle(
          //         color: Colors.white, fontSize: 20, fontFamily: 'Sarabun'))
        ],
      ),
    );
  }

  Widget textVersion(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      // height: MediaQuery.of(context).size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            "2023 Copyright INA. All Rights Reserved. version 0.1",
            style: GoogleFonts.sarabun(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  String passwordhash(String password) {
    var bytes = utf8.encode(password);
    var digest = sha1.convert(bytes);
    var bytes2 = utf8.encode(digest.toString());
    var digest2 = sha256.convert(bytes2);
    password = digest2.toString();
    return password;
  }

  Future<void> signoutprocess(BuildContext context, String header,
      String confirm, String cancel) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        alignment: Alignment.center,
        title: Center(
          child: Text(
            header,
            style: GoogleFonts.sarabun(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => const ScreenLogin(),
                  );
                  Navigator.pushAndRemoveUntil(
                      context, route, (route) => false);
                },
                child: Text(
                  confirm,
                  style: GoogleFonts.sarabun(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  cancel,
                  style: GoogleFonts.sarabun(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  MyObject();
}
