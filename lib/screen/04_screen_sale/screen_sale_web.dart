import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  List<Map<String, dynamic>> saleSelects = [];
  List<ModelProducts> modelProductsS = [];

  List<int> keepId = [];

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
      const Duration(seconds: 1),
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

  double calculatesum() {
    if (saleSelects.isEmpty) {
      return 0.0;
    } else {
      double total = 0.0;
      for (Map<String, dynamic> gettotal in saleSelects) {
        total += gettotal["product_amount"];
      }
      return total;
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
      backgroundColor: const Color(0xfff4f6f9),
      body: fullscreen(context),
    ));
  }

  Widget fullscreen(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          dispenserStatus(context),
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
                        children: [
                          menuNonOil(context),
                          bodySale(context),
                        ],
                      ),
                    ),
                  ),
                  menuPayment(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget dispenserStatus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                ),
              ],
              color: Colors.white

              // color: const Color(0xff343a40),
              ),
          child: modelDispenserStatuss.isEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return dispenserStatusNodata();
                  })
              : ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  itemCount: modelDispenserStatuss.length,
                  itemBuilder: (context, index) {
                    return dispenserStatusHaveData(
                        modelDispenserStatuss[index]);
                  })),
    );
  }

  Widget dispenserStatusNodata() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade200),
      ),
    );
  }

  Widget dispenserStatusHaveData(ModelDispenserStatus modelDispenserStatus) {
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
          borderRadius: BorderRadius.circular(5),
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

  Widget menuNonOil(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          listNonOil(context),
          searchNonOil(context),
        ],
      ),
    );
  }

  Widget listNonOil(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ],
          color: Colors.white),
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
                style: GoogleFonts.sarabun(fontSize: 20, color: Colors.black),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              child: modelProductsS.isEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: ((context, index) {
                        return menuNonOilNodata();
                      }))
                  : ListView.builder(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      scrollDirection: Axis.horizontal,
                      itemCount: modelProductsS.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                            onTap: () {
                              Map<String, dynamic> select = {
                                "product_code":
                                    modelProductsS[index].productCode,
                                "product_short":
                                    modelProductsS[index].productShort,
                                "product_volume": 1.0,
                                "product_amount":
                                    modelProductsS[index].productPrice!
                              };

                              if (saleSelects.isEmpty) {
                                setState(() {
                                  saleSelects.add(select);
                                });
                              } else {
                                bool dupitem = false;
                                for (Map<String, dynamic> saleSelect
                                    in saleSelects) {
                                  if (saleSelect["product_code"] ==
                                      select["product_code"]) {
                                    setState(() {
                                      saleSelect["product_volume"] +=
                                          select["product_volume"];
                                      saleSelect["product_amount"] +=
                                          select["product_amount"];
                                    });
                                    dupitem = true;
                                    break;
                                  }
                                }
                                if (dupitem == false) {
                                  setState(() {
                                    saleSelects.add(select);
                                  });
                                } else {}
                              }
                            },
                            child: menuNonOilHaveData(modelProductsS[index]));
                      })),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchNonOil(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      width: MediaQuery.of(context).size.width * 0.197,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ],
          color: Colors.white),
    );
  }

  Widget menuNonOilNodata() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 5),
      child: Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.06,
          height: MediaQuery.of(context).size.height * 0.1,
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
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget menuNonOilHaveData(ModelProducts modelProducts) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Expanded(
        child: Container(
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width * 0.06,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
              ),
            ],
            image: const DecorationImage(
              image: NetworkImage(
                  "https://www.b-quik.com/image/product/2hec2sry6u.3.png"),
              // image: NetworkImage(modelProducts.productPic!),
              fit: BoxFit.scaleDown,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.08,
            height: MediaQuery.of(context).size.height * 0.03,
            decoration: const BoxDecoration(
              color: Color(0xff007bff),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            ),
            child: Text(
              modelProducts.productShort!,
              style: GoogleFonts.sarabun(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget bodySale(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.65,
        child: Row(
          children: [
            transaction(context),
            transactionSelect(context),
          ],
        ),
      ),
    );
  }

  Widget transaction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.35,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                // border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
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
                  headerTransaction(context, "น้ำมัน"),
                  headerTransaction(context, "ยอดรวม"),
                  headerTransaction(context, "ราคา"),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.49,
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
                        Color colorSelect;
                        if (modelSaleNows[index].saleSelect == 1) {
                          colorSelect = const Color(0xffffc107);
                        } else {
                          colorSelect = const Color(0xffffffff);
                        }
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: InkWell(
                            onTap: () async {
                              Map<String, dynamic> selectItem = {
                                "transaction_id": modelSaleNows[index].id,
                                "product_code":
                                    modelSaleNows[index].productCode,
                                "product_short":
                                    modelSaleNows[index].productShort,
                                "product_volume":
                                    modelSaleNows[index].displayVolume!,
                                "product_amount":
                                    modelSaleNows[index].displayAmount!,
                              };
                              // setState(() {
                              //   modelSaleNows[index].saleSelect = 1;
                              // });
                              if (saleSelects.isEmpty) {
                                ApiSale().updateTranSactionSelect(
                                    modelSaleNows[index].id!, 1);
                                setState(() {
                                  keepId.add(modelSaleNows[index].id!);
                                  saleSelects.add(selectItem);
                                });
                              } else {
                                bool statecheck = false;
                                for (var loopCheck in saleSelects) {
                                  if (loopCheck["transaction_id"] ==
                                      selectItem["transaction_id"]) {
                                    statecheck = true;
                                    break;
                                  } else {}
                                }
                                if (statecheck == false) {
                                  ApiSale().updateTranSactionSelect(
                                      modelSaleNows[index].id!, 1);
                                  setState(() {
                                    keepId.add(modelSaleNows[index].id!);
                                    saleSelects.add(selectItem);
                                  });
                                } else {
                                  EasyLoading.showError("รายการนี้เลือกไปแล้ว");
                                }
                              }
                            },
                            child: Row(
                              children: [
                                bodyTransaction(context, (index + 1).toString(),
                                    Alignment.center, colorSelect),
                                bodyTransaction(
                                    context,
                                    modelSaleNows[index].dispenserId.toString(),
                                    Alignment.center,
                                    colorSelect),
                                bodyTransaction(
                                    context,
                                    modelSaleNows[index]
                                        .dispenserNozzle
                                        .toString(),
                                    Alignment.center,
                                    colorSelect),
                                bodyTransaction(
                                    context,
                                    modelSaleNows[index].productShort!,
                                    Alignment.center,
                                    colorSelect),
                                bodyTransaction(
                                    context,
                                    modelSaleNows[index]
                                        .displayAmount!
                                        .toStringAsFixed(2),
                                    Alignment.centerRight,
                                    colorSelect),
                                bodyTransaction(
                                    context,
                                    modelSaleNows[index]
                                        .displayPrice
                                        .toString(),
                                    Alignment.centerRight,
                                    colorSelect),
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
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
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
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                  ),
                  onPressed: () async {
                    setState(() {
                      saleSelects.clear();
                    });
                    if (keepId.isNotEmpty) {
                      for (var element in keepId) {
                        await ApiSale().updateTranSactionSelect(element, 0);
                      }
                      setState(() {
                        keepId.clear();
                      });
                    }
                  },
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

  Widget transactionSelect(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.4,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                color: Color(0xff007bff),
              ),
              child: Text(
                "รายการขาย",
                style: GoogleFonts.sarabun(fontSize: 20, color: Colors.white),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.4,
              color: const Color(0xff343a40),
              child: Row(
                children: [
                  headerTransaction(context, "ลำดับ"),
                  headerTransaction(context, "รหัสสินค้า"),
                  headerTransaction(context, "รายการ"),
                  headerTransaction(context, "จำนวน"),
                  headerTransaction(context, "ราคา"),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.49,
              width: MediaQuery.of(context).size.width * 0.4,
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
                      itemCount: saleSelects.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            children: [
                              bodyTransaction(context, (index + 1).toString(),
                                  Alignment.center, Colors.white),
                              bodyTransaction(
                                  context,
                                  saleSelects[index]["product_code"].toString(),
                                  Alignment.center,
                                  Colors.white),
                              bodyTransaction(
                                  context,
                                  saleSelects[index]["product_short"]
                                      .toString(),
                                  Alignment.center,
                                  Colors.white),
                              bodyTransaction(
                                  context,
                                  saleSelects[index]["product_volume"]
                                      .toStringAsFixed(2),
                                  Alignment.centerRight,
                                  Colors.white),
                              bodyTransaction(
                                  context,
                                  saleSelects[index]["product_amount"]
                                      .toStringAsFixed(2),
                                  Alignment.centerRight,
                                  Colors.white)
                            ],
                          ),
                        );
                      }),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ยอดที่ต้องชำระ",
                      style: GoogleFonts.sarabun(
                          fontSize: 30,
                          color: const Color.fromARGB(255, 0, 255, 13)),
                    ),
                    saleSelects.isEmpty
                        ? const SizedBox()
                        : Text(
                            calculatesum().toStringAsFixed(2),
                            style: GoogleFonts.sarabun(
                                fontSize: 30,
                                color: const Color.fromARGB(255, 0, 255, 13)),
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
      BuildContext context, String header, Alignment alignment, Color color) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: alignment,
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: color,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
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

  Widget menuPayment(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 5),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(children: [
            menuPaymentType(context),
            menuTextAmount(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                color: Colors.purple,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget menuTextAmount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
              ),
            ],
            color: Colors.white),
      ),
    );
  }

  Widget menuPaymentType(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buttonCash(context),
          buttonCredit(context),
          buttonQr(context),
        ],
      ),
    );
  }

  Widget buttonCash(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
        width: size.width * 0.09,
        height: size.height * 0.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
              ),
            ],
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              width: size.width * 0.09,
              height: size.height * 0.1,
              child: const Image(
                  image: AssetImage("assets/image/money.png"),
                  fit: BoxFit.fitHeight),
            ),
            Container(
              width: size.width * 0.09,
              height: size.height * 0.03,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Text(
                "เงินสด",
                style: GoogleFonts.sarabun(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonCredit(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
        width: size.width * 0.09,
        height: size.height * 0.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
              ),
            ],
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              width: size.width * 0.09,
              height: size.height * 0.1,
              child: const Image(
                image: AssetImage("assets/image/credit-card.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: size.width * 0.09,
              height: size.height * 0.03,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Text(
                "บัตรเครดิต",
                style: GoogleFonts.sarabun(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonQr(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
        width: size.width * 0.09,
        height: size.height * 0.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
              ),
            ],
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              width: size.width * 0.09,
              height: size.height * 0.1,
              child: const Image(
                image: AssetImage("assets/image/barcode-scan.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: size.width * 0.09,
              height: size.height * 0.03,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Text(
                "Scan จ่าย",
                style: GoogleFonts.sarabun(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
