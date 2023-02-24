import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_pos_project_2566_01_26/model/model_getmeter.dart';
import 'package:new_pos_project_2566_01_26/model/model_products.dart';
import 'package:new_pos_project_2566_01_26/model/model_shift.dart';
import 'package:new_pos_project_2566_01_26/model/model_shift_meter.dart';
import 'package:new_pos_project_2566_01_26/model/model_user.dart';

import '../../api/api.dart';

class WebScreenOpenCloseShift extends StatefulWidget {
  final ModelUser modelUser;
  const WebScreenOpenCloseShift({super.key, required this.modelUser});

  @override
  State<WebScreenOpenCloseShift> createState() =>
      _WebScreenOpenCloseShiftState();
}

class _WebScreenOpenCloseShiftState extends State<WebScreenOpenCloseShift> {
  DateTime accountDate = DateTime.now();
  TextEditingController tbAccountDate = TextEditingController();
  TextEditingController tbCashierName = TextEditingController();
  TextEditingController tbStartShift = TextEditingController();
  TextEditingController tbShift = TextEditingController();
  TextEditingController tbChange = TextEditingController();

  List<ModelGetmeter> modelGetmeters = [];
  List<ModelShiftMeter> modelShiftMeters = [];
  List<ModelProducts> modelProducts = [];
  ModelShift? modelShift;

  String? _accountDate;

  bool boolDay = false;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) async {
        setState(() {
          accountDate = DateTime.now();
          tbStartShift.text = accountDate.toString().split(".")[0];
        });
      },
    );
  }

  Future<void> checkDay() async {
    String responseday = await API().getDayOpen();
    print("checkDay() in open_close_web : $responseday");
    if (responseday == "null" || responseday == "Day open not found") {
      setState(() {
        boolDay = false;
        tbShift.text = "1";
        _accountDate = accountDate.toString().split(".")[0];
        tbAccountDate.text = _accountDate.toString().split(" ")[0];
        tbStartShift.text = _accountDate.toString().split(".")[0];
        tbCashierName.text =
            "${widget.modelUser.respMsg!.userFirstname} ${widget.modelUser.respMsg!.userLastname}";
        startTimer();
        getmeter();
      });
    } else {
      setState(() {
        boolDay = true;
        _timer?.cancel();
        getshiftdetail(responseday);
      });
    }
  }

  Future<void> getallproduct() async {
    List<ModelProducts> res = await API().getProducts();
    setState(() {
      modelProducts.addAll(res);
    });
  }

  Future<void> getshiftdetail(String date) async {
    ModelShift _modelShift = await API().getDayOpenByDate(date);
    setState(() {
      modelShift = _modelShift;
      tbAccountDate.text = _modelShift.dayAccountdate!;
      tbStartShift.text =
          "${_modelShift.shiftStartshift!.split("T")[0]} ${_modelShift.shiftStartshift!.split("T")[1]}";
      tbCashierName.text = _modelShift.userFullname!;
      tbChange.text = _modelShift.shiftChange.toString();
      tbShift.text = _modelShift.shiftNo.toString();
      getmetershift();
    });
  }

  Future<void> getmeter() async {
    List<ModelGetmeter> resp = await API().getMeter();
    setState(() {
      modelGetmeters.addAll(resp);
    });
  }

  Future<void> getmetershift() async {
    List<ModelShiftMeter> resp = await API().getShiftByDate(
        modelShift!.dayAccountdate!, modelShift!.shiftNo.toString());
    setState(() {
      modelShiftMeters.addAll(resp);
    });
  }

  @override
  void initState() {
    super.initState();
    checkDay();
    getallproduct();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff454d55),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          _body(context),
          _buttongroup(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    accountdate(),
                    cashiername(),
                    startshift(),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    shiftno(),
                    change(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        // color: const Color.fromARGB(255, 131, 190, 255),
        child: Row(
          children: [
            showmeter(context),
            showPrice(context),
          ],
        ),
      ),
    );
  }

  Widget accountdate() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width * 0.1,
          // height: MediaQuery.of(context).size.height * 0.05,
          child: Text(
            "วันที่ทางบัญชี",
            textAlign: TextAlign.right,
            style: GoogleFonts.sarabun(fontSize: 18, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: GoogleFonts.sarabun(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              readOnly: true,
              controller: tbAccountDate,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cashiername() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width * 0.1,
          // height: MediaQuery.of(context).size.height * 0.05,
          child: Text(
            "แคชเชียร์",
            textAlign: TextAlign.right,
            style: GoogleFonts.sarabun(fontSize: 18, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: GoogleFonts.sarabun(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              readOnly: true,
              controller: tbCashierName,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget change() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width * 0.1,
          // height: MediaQuery.of(context).size.height * 0.05,
          child: Text(
            "เงินทอน",
            textAlign: TextAlign.right,
            style: GoogleFonts.sarabun(fontSize: 18, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              maxLength: 5,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.sarabun(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              readOnly: false,
              controller: tbChange,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: "",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget startshift() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width * 0.1,
          // height: MediaQuery.of(context).size.height * 0.05,
          child: Text(
            "เวลาเริ่มกะ",
            textAlign: TextAlign.right,
            style: GoogleFonts.sarabun(fontSize: 18, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: GoogleFonts.sarabun(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              readOnly: true,
              controller: tbStartShift,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget shiftno() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width * 0.1,
          // height: MediaQuery.of(context).size.height * 0.05,
          child: Text(
            "หมายเลขกะ",
            textAlign: TextAlign.right,
            style: GoogleFonts.sarabun(fontSize: 18, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: GoogleFonts.sarabun(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              readOnly: true,
              controller: tbShift,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget showmeter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              alignment: Alignment.centerLeft,
              child: Center(
                child: Text(
                  "มิเตอร์ ก่อนขาย - หลังขาย",
                  style: GoogleFonts.sarabun(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  rowheader(context, 10, 0, "ลำดับ"),
                  rowheader(context, 0, 0, "หน้าจ่าย"),
                  rowheader(context, 0, 0, "มือจ่าย"),
                  rowheader(context, 0, 0, "น้ำมัน"),
                  rowheader(context, 0, 0, "มิเตอร์ลิตรเริ่มต้น"),
                  rowheader(context, 0, 0, "มิเตอร์บาทเริ่มต้น"),
                  rowheader(context, 0, 0, "มิเตอร์ลิตรสิ้นสุด"),
                  rowheader(context, 0, 10, "มิเตอร์บาทสิ้นสุด"),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child:
                    boolDay ? showDispenser2(context) : showDispenser(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showPrice(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    "ราคาสินค้า",
                    style: GoogleFonts.sarabun(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    rowheader(context, 10, 0, "ลำดับ"),
                    rowheader(context, 0, 0, "ผลิตภัณฑ์"),
                    rowheader(context, 0, 0, "ประเภท"),
                    rowheader(context, 0, 0, "ราคา"),
                    rowheader(context, 0, 10, "หน่วยนับ"),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: showProduct(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowheader(
      BuildContext context, double left, double right, String header) {
    return Flexible(
      flex: 1,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa0a6ab),
                Color(0xff6c757d),
              ],
            ),
            // color: const Color(0xFF6c757d),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(left),
              topRight: Radius.circular(right),
            )),
        alignment: Alignment.center,
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

  Widget rowbody(BuildContext context, double left, double right, String header,
      Alignment alignment) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 1,
          ),
        )),
        alignment: alignment,
        child: Text(
          header,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.sarabun(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget showDispenser(BuildContext context) {
    print("showDispenser = $modelGetmeters");
    return modelGetmeters.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: modelGetmeters.length,
            itemBuilder: (context, i) {
              return Row(
                children: [
                  rowbody(context, 10, 0, (i + 1).toString(), Alignment.center),
                  rowbody(
                      context,
                      0,
                      0,
                      modelGetmeters[i].dispenserId!.toString(),
                      Alignment.center),
                  rowbody(
                      context,
                      0,
                      0,
                      modelGetmeters[i].dispenserNozzle!.toString(),
                      Alignment.center),
                  rowbody(context, 0, 0, modelGetmeters[i].productDescription!,
                      Alignment.centerLeft),
                  rowbody(
                      context,
                      0,
                      0,
                      modelGetmeters[i]
                          .dispenserMeterVolume!
                          .toStringAsFixed(2),
                      Alignment.centerRight),
                  rowbody(
                      context,
                      0,
                      0,
                      modelGetmeters[i]
                          .dispenserMeterAmount!
                          .toStringAsFixed(2),
                      Alignment.centerRight),
                  rowbody(context, 0, 0, "0.00", Alignment.centerRight),
                  rowbody(context, 0, 10, "0.00", Alignment.centerRight),
                ],
              );
            });
  }

  Widget showDispenser2(BuildContext context) {
    print("showDispenser2 = $modelShiftMeters");
    return modelShiftMeters.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: modelShiftMeters.length,
            itemBuilder: (context, i) {
              return Row(
                children: [
                  rowbody(context, 10, 0, modelShiftMeters[i].id.toString(),
                      Alignment.center),
                  rowbody(
                      context,
                      0,
                      0,
                      modelShiftMeters[i].dispenserId!.toString(),
                      Alignment.center),
                  rowbody(
                      context,
                      0,
                      0,
                      modelShiftMeters[i].dispenserNozzle!.toString(),
                      Alignment.center),
                  rowbody(
                      context,
                      0,
                      0,
                      modelShiftMeters[i].productDescription!,
                      Alignment.centerLeft),
                  rowbody(
                      context,
                      0,
                      0,
                      modelShiftMeters[i].startMeterVolume!.toStringAsFixed(2),
                      Alignment.centerRight),
                  rowbody(
                      context,
                      0,
                      0,
                      modelShiftMeters[i].startMeterAmount!.toStringAsFixed(2),
                      Alignment.centerRight),
                  rowbody(
                      context,
                      0,
                      0,
                      modelShiftMeters[i].endMeterVolume!.toStringAsFixed(2),
                      Alignment.centerRight),
                  rowbody(
                      context,
                      0,
                      10,
                      modelShiftMeters[i].endMeterAmount!.toStringAsFixed(2),
                      Alignment.centerRight),
                ],
              );
            });
  }

  Widget showProduct(BuildContext context) {
    return modelProducts.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: modelProducts.length,
            itemBuilder: (context, i) {
              return Row(
                children: [
                  rowbody(context, 10, 0, (i + 1).toString(), Alignment.center),
                  rowbody(context, 0, 0, modelProducts[i].productShort!,
                      Alignment.centerLeft),
                  rowbody(
                      context,
                      0,
                      0,
                      modelProducts[i].productType!.toString(),
                      Alignment.center),
                  rowbody(
                      context,
                      0,
                      0,
                      modelProducts[i].productPrice!.toStringAsFixed(2),
                      Alignment.centerRight),
                  rowbody(context, 0, 10, modelProducts[i].productUnits!,
                      Alignment.center),
                ],
              );
            });
  }

  Widget _buttongroup(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.1,
      // color: const Color.fromARGB(255, 131, 190, 255),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AbsorbPointer(
            absorbing: boolDay ? true : false,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    boolDay ? const Color(0xFF6c757d) : const Color(0xFF007bff),
                elevation: 10,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.1,
                    MediaQuery.of(context).size.height * 0.07),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => boolDay ? null : openshift(),
              child: Text(
                "เปิดกะ",
                style: GoogleFonts.sarabun(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          AbsorbPointer(
            absorbing: boolDay ? false : true,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    boolDay ? const Color(0xFFdc3545) : const Color(0xFF6c757d),
                elevation: 10,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.1,
                    MediaQuery.of(context).size.height * 0.07),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: Text(
                "ปิดกะ",
                style: GoogleFonts.sarabun(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          AbsorbPointer(
            absorbing: boolDay ? false : true,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    boolDay ? const Color(0xFFffc107) : const Color(0xFF6c757d),
                elevation: 10,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.1,
                    MediaQuery.of(context).size.height * 0.07),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: Text(
                "ปิดวัน",
                style: GoogleFonts.sarabun(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF28a745),
              elevation: 10,
              fixedSize: Size(MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.07),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {},
            child: Text(
              "พิมพ์ซ้ำ",
              style: GoogleFonts.sarabun(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openshift() {
    if (tbChange.text.isEmpty || tbChange.text == "") {
      EasyLoading.showError("กรุณาระบุเงินทอน");
    } else {
      apiOpenShift();
    }
  }

  Future<void> apiOpenShift() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Center(
          child: Text(
            "คุณต้องการเปิดกะใช่หรือไม่",
            style: GoogleFonts.sarabun(fontSize: 15),
          ),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  Navigator.pop(context);
                  EasyLoading.show(status: "กรุณารอสักครู่");
                  List dataDispenser = [];
                  for (var item in modelGetmeters) {
                    var sub = <String, dynamic>{
                      "dispenser_id": item.dispenserId,
                      "dispenser_nozzle": item.dispenserNozzle,
                      "dispenser_meter_volume": item.dispenserMeterVolume,
                      "dispenser_meter_amount": item.dispenserMeterAmount,
                      "product_code": item.productCode,
                      "product_description": item.productDescription
                    };

                    dataDispenser.add(sub);
                  }
                  var data = jsonEncode(<String, dynamic>{
                    "day_accountdate": tbAccountDate.text,
                    "user_fullname_start":
                        "${widget.modelUser.respMsg!.userFirstname} ${widget.modelUser.respMsg!.userLastname}",
                    "shift_startshift": tbStartShift.text,
                    "shift_no": tbShift.text,
                    "shift_change": tbChange.text,
                    "data": dataDispenser
                  });
                  await API().postOpenShift(data).then((value) {
                    if (value == "create success") {
                      EasyLoading.showSuccess("บันทึกการเปิดกะสำเร็จ");
                      checkDay();
                    }
                  });
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                label: Text(
                  "ตกลง",
                  style: GoogleFonts.sarabun(fontSize: 15),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                label: Text(
                  "ยกเลิก",
                  style: GoogleFonts.sarabun(fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
