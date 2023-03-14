// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_pos_project_2566_01_26/api/api.dart';
import 'package:new_pos_project_2566_01_26/model/model_user.dart';
import 'package:new_pos_project_2566_01_26/screen/03_screen_open_close_shift/screen_open_close_shift.dart';
import 'package:new_pos_project_2566_01_26/screen/05_screen_reciept/screen_reciept.dart';
import 'package:new_pos_project_2566_01_26/screen/06_screen_tax/screen_tax.dart';
import 'package:new_pos_project_2566_01_26/screen/07_screen_test_oil/screen_test_oil.dart';
import 'package:new_pos_project_2566_01_26/screen/08_screen_product/screen_product.dart';
import 'package:new_pos_project_2566_01_26/screen/09_screen_safedrop/screen_safedrop.dart';
import 'package:new_pos_project_2566_01_26/screen/10_screen_user/screen_user.dart';
import 'package:new_pos_project_2566_01_26/screen/11_screen_history/screen_history.dart';
import 'package:new_pos_project_2566_01_26/screen/12_screen_read_meter/screen_read_meter.dart';
import 'package:new_pos_project_2566_01_26/screen/13_screen_inv_credit/screen_inv_credit.dart';
import 'package:new_pos_project_2566_01_26/utility/style.dart';

import '../04_screen_sale/screen_sale.dart';

class WebScreenHomepage extends StatefulWidget {
  final ModelUser modelUser;
  const WebScreenHomepage({super.key, required this.modelUser});

  @override
  State<WebScreenHomepage> createState() => _WebScreenHomepageState();
}

class _WebScreenHomepageState extends State<WebScreenHomepage> {
  String? nameAppbar;
  bool boolShift = false;
  bool boolDay = false;
  Widget? currentWidget;

  // Widget currentWidget = ScreenSale(modelUser: widget.modelUser,);

  Future<void> checkDay() async {
    String responseday = await API().getDayOpen();
    print("checkDay() in home_web : $responseday");
    if (responseday == "null" || responseday == "Day open not found") {
      setState(() {
        boolDay = false;
        nameAppbar = "เปิด/ปิด กะ";
        currentWidget = ScreenOpenCloseShift(modelUser: widget.modelUser);
      });
    } else {
      setState(() {
        boolDay = true;
        nameAppbar = "รายการขาย";
        currentWidget = ScreenSale(modelUser: widget.modelUser);
      });
    }
  }

  Future<void> checkDay2() async {
    String responseday = await API().getDayOpen();
    print("checkDay() in home_web : $responseday");
    if (responseday == "null" || responseday == "Day open not found") {
      setState(() {
        boolDay = false;
      });
    } else {
      setState(() {
        boolDay = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameAppbar = "รายการขาย";
    checkDay();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff343a40),
          centerTitle: true,
          title: Text(
            "$nameAppbar",
            style: GoogleFonts.sarabun(fontSize: 20),
          ),
          actions: [
            nameAppbar != "รายการขาย"
                ? Center(
                    child: Text(
                        "ผู้ใช้งาน : ${widget.modelUser.respMsg!.userFirstname} ${widget.modelUser.respMsg!.userLastname} ",
                        style: GoogleFonts.sarabun(fontSize: 20)),
                  )
                : Center(
                    child: Row(
                      children: [
                        Text(
                          "ข้อมูลหัวจ่าย",
                          style: GoogleFonts.sarabun(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xffa0a6ab),
                                  Color(0xff6c757d),
                                ]),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          ": วางมือจ่าย",
                          style: GoogleFonts.sarabun(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xfffeac67), Color(0xfffd7e14)]),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          ": ยกมือจ่าย",
                          style: GoogleFonts.sarabun(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xffffd75f), Color(0xffffc107)]),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          ": กำลังเติม",
                          style: GoogleFonts.sarabun(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xffa285d7), Color(0xff6f42c1)]),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          ": เติมเสร็จ",
                          style: GoogleFonts.sarabun(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
            IconButton(
              onPressed: () async {
                MyObject()
                    .signoutprocess(context, "ออกจากระบบ", "ตกลง", "ยกเลิก");
              },
              icon: const Icon(
                Icons.settings,
                size: 30,
              ),
            ),
          ],
        ),
        drawer: showDrawer(context),
        // body: boolDay ? True : False,
        body: currentWidget,
      ),
    );
  }

  Widget showDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF343a40),
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              menuDrawer(context, "เปิด/ปิด กะ"),
              menuDrawer(context, "รายการขาย"),
              menuDrawer(context, "พิมพ์/ยกเลิก ใบเสร็จรับเงิน"),
              menuDrawer(context, "พิมพ์/ยกเลิก ใบกำกับภาษี"),
              menuDrawer(context, "เบิก/ทดสอบน้ำมัน"),
              menuDrawer(context, "สินค้า"),
              menuDrawer(context, "เซฟดรอป"),
              menuDrawer(context, "ผู้ใช้งานระบบ"),
              menuDrawer(context, "ประวัติการขาย"),
              menuDrawer(context, "อ่านมิเตอร์"),
              menuDrawer(context, "การขายแบบใบเนอราคา"),
              menuDrawer(context, "ดึงเลขมิเตอร์ตั้งต้น"),
              menuDrawer(context, "เลือกธีมสี"),
              // menuDrawer(context,"ออกจากระบบ")
            ],
          )
        ],
      ),
    );
  }

  Widget menuDrawer(BuildContext context, String menu) {
    return ListTile(
      hoverColor: const Color(0xFF5a5a5a),
      selectedColor: const Color(0xFFebecec),
      title: Text(
        menu,
        style: GoogleFonts.sarabun(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      onTap: () async {
        await checkDay2();
        Navigator.pop(context);

        if (menu == "เปิด/ปิด กะ") {
          setState(() {
            currentWidget = ScreenOpenCloseShift(modelUser: widget.modelUser);
            nameAppbar = menu;
          });
        } else if (menu == "รายการขาย") {
          if (boolDay == false) {
            EasyLoading.showError("กรุณาเปิดกะก่อน");
          } else {
            setState(() {
              currentWidget = ScreenSale(modelUser: widget.modelUser);
              nameAppbar = menu;
            });
          }
        } else if (menu == "พิมพ์/ยกเลิก ใบเสร็จรับเงิน") {
          if (boolDay == false) {
            EasyLoading.showError("กรุณาเปิดกะก่อน");
          } else {
            setState(() {
              currentWidget = const ScreenReciept();
              nameAppbar = menu;
            });
          }
        } else if (menu == "พิมพ์/ยกเลิก ใบกำกับภาษี") {
          if (boolDay == false) {
            EasyLoading.showError("กรุณาเปิดกะก่อน");
          } else {
            setState(() {
              currentWidget = const ScreenTax();
              nameAppbar = menu;
            });
          }
        } else if (menu == "เบิก/ทดสอบน้ำมัน") {
          if (boolDay == false) {
            EasyLoading.showError("กรุณาเปิดกะก่อน");
          } else {
            setState(() {
              currentWidget = const ScreenTestOil();
              nameAppbar = menu;
            });
          }
        } else if (menu == "สินค้า") {
          setState(() {
            currentWidget = const ScreenProduct();
            nameAppbar = menu;
          });
        } else if (menu == "เซฟดรอป") {
          if (boolDay == false) {
            EasyLoading.showError("กรุณาเปิดกะก่อน");
          } else {
            setState(() {
              currentWidget = const ScreenSafedrop();
              nameAppbar = menu;
            });
          }
        } else if (menu == "ผู้ใช้งานระบบ") {
          setState(() {
            currentWidget = const ScreenUser();
            nameAppbar = menu;
          });
        } else if (menu == "ประวัติการขาย") {
          if (boolDay == false) {
            EasyLoading.showError("กรุณาเปิดกะก่อน");
          } else {
            setState(() {
              currentWidget = const ScreenHistory();
              nameAppbar = menu;
            });
          }
        } else if (menu == "อ่านมิเตอร์") {
          setState(() {
            currentWidget = const ScreenReadMeter();
            nameAppbar = menu;
          });
        } else if (menu == "การขายแบบใบเนอราคา") {
          setState(() {
            currentWidget = const ScreenInvCredit();
            nameAppbar = menu;
          });
        }
      },
    );
  }
}
