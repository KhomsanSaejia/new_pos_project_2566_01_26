import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  Timer? timerDispenserStatus;

  void getDispenserStatus() {
    timerDispenserStatus = Timer.periodic(
      const Duration(seconds: 2),
      (Timer timer) async {
        final statusDispenser = await ApiSale().getDispenserStatus();
        final listTransaction = await ApiSale().getAllTransactionNow();

        setState(() {
          modelDispenserStatuss
            ..clear()
            ..addAll(statusDispenser);

          modelSaleNows
            ..clear()
            ..addAll(listTransaction);
        });
      },
    );
  }

  Future<void> once() async {
    final statusDispenser = await ApiSale().getDispenserStatus();
    final listTransaction = await ApiSale().getAllTransactionNow();

    setState(() {
      modelDispenserStatuss
        ..clear()
        ..addAll(statusDispenser);

      modelSaleNows
        ..clear()
        ..addAll(listTransaction);
    });
  }

  @override
  void initState() {
    super.initState();
    once();
    getDispenserStatus();
  }

  @override
  void dispose() {
    super.dispose();
    timerDispenserStatus?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: fullscreen(context),
    ));
  }

  Widget fullscreen(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.grey.shade200,
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
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.pink,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.green,
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

  Widget rowHead(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.13,
          child: modelDispenserStatuss.isEmpty
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return customCardNodata();
                  })
              : ListView.builder(
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
    List<Color> status;
    if (modelDispenserStatus.pumpStatus == "12") {
      status = const [Color(0xffD5DBDB), Color(0xff95A5A6)];
    } else if (modelDispenserStatus.pumpStatus == "13") {
      status = const [Color(0xffFAD7A0), Color(0xffF39C12)];
    } else if (modelDispenserStatus.pumpStatus == "14") {
      status = const [Color(0xffF9E79F), Color(0xffF1C40F)];
    } else if (modelDispenserStatus.pumpStatus == "15") {
      status = const [Color(0xffD2B4DE), Color(0xff8E44AD)];
    } else {
      status = const [Color(0xffCACFD2), Color(0xff797D7F)];
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
                              fontSize: 18, color: Colors.black),
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
                                    fontSize: 18, color: Colors.black),
                              )
                            : Text(
                                "มือจ่าย:${modelDispenserStatus.dispenserNozzle}",
                                style: GoogleFonts.sarabun(
                                    fontSize: 18, color: Colors.black),
                              ),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(5),
                        //   gradient: const LinearGradient(
                        //     begin: Alignment.topCenter,
                        //     end: Alignment.bottomCenter,
                        //     colors: [
                        //       Color(0xFF6c757d),
                        //       Color(0xFF424949),
                        //     ],
                        //   ),
                        // ),
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
                      style: GoogleFonts.sarabun(
                          fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      modelDispenserStatus.displayAmount!.toStringAsFixed(1),
                      style: GoogleFonts.sarabun(
                          fontSize: 18, color: Colors.black),
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
                      style: GoogleFonts.sarabun(
                          fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      modelDispenserStatus.displayVolume!.toStringAsFixed(2),
                      style: GoogleFonts.sarabun(
                          fontSize: 18, color: Colors.black),
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
                      style: GoogleFonts.sarabun(
                          fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      modelDispenserStatus.displayPrice!.toStringAsFixed(2),
                      style: GoogleFonts.sarabun(
                          fontSize: 18, color: Colors.black),
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
