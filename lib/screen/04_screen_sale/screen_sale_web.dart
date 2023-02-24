import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_pos_project_2566_01_26/model/model_products.dart';

import '../../api/api_sale.dart';
import '../../model/model_dispenser_status.dart';
import '../../model/model_user.dart';
import '../../model/model_sale_now.dart';

class WebScreenSale extends StatefulWidget {
  final ModelUser modelUser;
  const WebScreenSale({super.key, required this.modelUser});

  @override
  State<WebScreenSale> createState() => _WebScreenSaleState();
}

class _WebScreenSaleState extends State<WebScreenSale> {
  List<ModelDispenserStatus> modelDispenserStatuss = [];
  List<ModelSaleNow> modelSaleNows = [];
  List<ModelProducts> modelProductsS = [];

  Timer? timerDispenserStatus;
  Timer? timerTransaction;

  void getDispenserStatus() {
    timerDispenserStatus = Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) async {
        try {
          final statusDispenser = await ApiSale().getDispenserStatus();

          setState(() {
            modelDispenserStatuss
              ..clear()
              ..addAll(statusDispenser);
          });
        } catch (e) {
          print('Error occurred getDispenserStatus: $e');
        }
      },
    );
  }

  void getTransaction() {
    timerTransaction = Timer.periodic(
      const Duration(seconds: 2),
      (Timer timer) async {
        try {
          final listTransaction = await ApiSale().getAllTransactionNow();

          setState(() {
            modelSaleNows
              ..clear()
              ..addAll(listTransaction);
          });
        } catch (e) {
          print('Error occurred getAllTransactionNow: $e');
        }
      },
    );
  }

  Future<void> once() async {
    try {
      final statusDispenser = await ApiSale().getDispenserStatus();

      setState(() {
        modelDispenserStatuss
          ..clear()
          ..addAll(statusDispenser);
      });
    } catch (e) {
      print('Error occurred getDispenserStatus: $e');
    }
    try {
      final listTransaction = await ApiSale().getAllTransactionNow();
      setState(() {
        modelSaleNows
          ..clear()
          ..addAll(listTransaction);
      });
    } catch (e) {
      print('Error occurred getAllTransactionNow: $e');
    }
    try {
      final lostNonoil = await ApiSale().getProductsNonOil();
      setState(() {
        modelProductsS
          ..clear()
          ..addAll(lostNonoil);
      });
    } catch (e) {
      print('Error occurred getProductsNonOil: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    once();
    getDispenserStatus();
    getTransaction();
  }

  @override
  void dispose() {
    timerDispenserStatus?.cancel();
    timerTransaction?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff454d55),
      body: fullscreen(context),
    ));
  }

  Widget fullscreen(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          rowHead(context),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5, bottom: 5, right: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [listNonOil(context), bodySale(context)],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff343a40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bodySale(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Row(
          children: [
            transaction(context),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff343a40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget transaction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.35,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                // border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Color(0xff007bff),
              ),
              child: Text(
                "รายการน้ำมัน",
                style: GoogleFonts.sarabun(fontSize: 20, color: Colors.white),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.35,
              color: const Color(0xff343a40),
              child: Row(
                children: [
                  headerTransaction(context, "ลำดับ"),
                  headerTransaction(context, "หน้าจ่าย"),
                  headerTransaction(context, "มือจ่าย"),
                  headerTransaction(context, "ยอดรวม"),
                  headerTransaction(context, "น้ำมัน"),
                  headerTransaction(context, "ราคา"),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.43,
              width: MediaQuery.of(context).size.width * 0.35,
              color: Colors.white,
              child: modelSaleNows.isEmpty
                  ? Center(
                      child: Text(
                        "ไม่พบข้อมูลการขาย",
                        style: GoogleFonts.sarabun(
                            fontSize: 30, color: Colors.black),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: modelSaleNows.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: InkWell(
                            onTap: () {
                              print(modelSaleNows[index].id);
                            },
                            child: Row(
                              children: [
                                bodyTransaction(context, (index + 1).toString(),
                                    Alignment.center),
                                bodyTransaction(
                                    context,
                                    modelSaleNows[index].dispenserId.toString(),
                                    Alignment.center),
                                bodyTransaction(
                                    context,
                                    modelSaleNows[index]
                                        .dispenserNozzle
                                        .toString(),
                                    Alignment.center),
                                bodyTransaction(
                                    context,
                                    modelSaleNows[index].productShort!,
                                    Alignment.centerLeft),
                                bodyTransaction(
                                    context,
                                    modelSaleNows[index]
                                        .displayAmount!
                                        .toStringAsFixed(2),
                                    Alignment.centerRight),
                                bodyTransaction(
                                    context,
                                    modelSaleNows[index]
                                        .displayPrice
                                        .toString(),
                                    Alignment.centerRight),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Color(0xff343a40),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007BFF),
                    elevation: 10,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.2,
                        MediaQuery.of(context).size.height * 0.04),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                  ),
                  onPressed: () {},
                  child: Text(
                    "เรียกคืนรายการขาย",
                    style:
                        GoogleFonts.sarabun(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerTransaction(BuildContext context, String header) {
    return Flexible(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: const BoxDecoration(
          color: Color(0xff343a40),
        ),
        child: Text(
          header,
          style: GoogleFonts.sarabun(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget bodyTransaction(
      BuildContext context, String header, Alignment alignment) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: alignment,
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.black),
                left: BorderSide(color: Colors.black),
                right: BorderSide(color: Colors.black))),
        child: Text(
          header,
          style: GoogleFonts.sarabun(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget listNonOil(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
          padding: const EdgeInsets.only(left: 5),
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff343a40),
          ),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ข้อมูลสินค้า",
                    style:
                        GoogleFonts.sarabun(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: modelProductsS.isEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          controller: ScrollController(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: ((context, index) {
                            return cradNonoilNodata();
                          }))
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: ScrollController(),
                          scrollDirection: Axis.horizontal,
                          itemCount: modelProductsS.length,
                          itemBuilder: ((context, index) {
                            return cradNonoilHaveData(modelProductsS[index]);
                          })),
                ),
              ],
            ),
          )),
    );
  }

  Widget cradNonoilHaveData(ModelProducts modelProducts) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 5),
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.08,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffa0a6ab),
                  Color(0xff6c757d),
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowdatanonoil("รหัสสินค้า :", modelProducts.productCode!),
              rowdatanonoil("สินค้า :", modelProducts.productShort!),
              rowdatanonoil(
                  "ราคา :", modelProducts.productPrice!.toStringAsFixed(2)),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowdatanonoil(String header, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.04,
            alignment: Alignment.centerLeft,
            child: Text(
              header,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.sarabun(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.04,
            alignment: Alignment.centerRight,
            child: Text(
              data,
              overflow: TextOverflow.clip,
              style: GoogleFonts.sarabun(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cradNonoilNodata() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 5),
      child: Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.08,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffa0a6ab),
                  Color(0xff6c757d),
                ]),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget rowHead(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff343a40),
          ),
          child: modelDispenserStatuss.isEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return customCardNodata();
                  })
              : ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  itemCount: modelDispenserStatuss.length,
                  itemBuilder: (context, index) {
                    return customCardHaveData(modelDispenserStatuss[index]);
                  })),
    );
  }

  Widget customCardNodata() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200),
      ),
    );
  }

  Widget customCardHaveData(ModelDispenserStatus modelDispenserStatus) {
    List<Color> status = const [Color(0xffa0a6ab), Color(0xff6c757d)];
    Color fontColor = Colors.white;
    switch (modelDispenserStatus.pumpStatus) {
      case "12":
        status = const [Color(0xffa0a6ab), Color(0xff6c757d)];
        fontColor = Colors.white;
        break;
      case "13":
        status = const [Color(0xfffeac67), Color(0xfffd7e14)];
        fontColor = Colors.black;
        break;
      case "14":
        status = const [Color(0xffffd75f), Color(0xffffc107)];
        fontColor = Colors.black;
        break;
      case "15":
        status = const [Color(0xffa285d7), Color(0xff6f42c1)];
        fontColor = Colors.white;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: status),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "หน้า:${modelDispenserStatus.dispenserId}",
                          style: GoogleFonts.sarabun(
                              fontSize: 18, color: fontColor),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.centerRight,
                        child: modelDispenserStatus.dispenserNozzle == 0
                            ? Text(
                                "",
                                style: GoogleFonts.sarabun(
                                    fontSize: 18, color: fontColor),
                              )
                            : Text(
                                "มือ:${modelDispenserStatus.dispenserNozzle}",
                                style: GoogleFonts.sarabun(
                                    fontSize: 18, color: fontColor),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "ยอดเงิน",
                      style:
                          GoogleFonts.sarabun(fontSize: 18, color: fontColor),
                    ),
                    Text(
                      modelDispenserStatus.displayAmount!.toStringAsFixed(1),
                      style:
                          GoogleFonts.sarabun(fontSize: 18, color: fontColor),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "ยอดลิตร",
                      style:
                          GoogleFonts.sarabun(fontSize: 18, color: fontColor),
                    ),
                    Text(
                      modelDispenserStatus.displayVolume!.toStringAsFixed(2),
                      style:
                          GoogleFonts.sarabun(fontSize: 18, color: fontColor),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "ราคา",
                      style:
                          GoogleFonts.sarabun(fontSize: 18, color: fontColor),
                    ),
                    Text(
                      modelDispenserStatus.displayPrice!.toStringAsFixed(2),
                      style:
                          GoogleFonts.sarabun(fontSize: 18, color: fontColor),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
