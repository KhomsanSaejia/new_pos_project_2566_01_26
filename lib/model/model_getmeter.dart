class ModelGetmeter {
  int? id;
  int? dispenserId;
  int? dispenserNozzle;
  double? dispenserMeterVolume;
  double? dispenserMeterAmount;
  String? productCode;
  String? productDescription;
  String? updateDate;

  ModelGetmeter(
      {this.id,
      this.dispenserId,
      this.dispenserNozzle,
      this.dispenserMeterVolume,
      this.dispenserMeterAmount,
      this.productCode,
      this.productDescription,
      this.updateDate});

  ModelGetmeter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dispenserId = json['dispenser_id'];
    dispenserNozzle = json['dispenser_nozzle'];
    dispenserMeterVolume = json['dispenser_meter_volume'];
    dispenserMeterAmount = json['dispenser_meter_amount'];
    productCode = json['product_code'];
    productDescription = json['product_description'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dispenser_id'] = this.dispenserId;
    data['dispenser_nozzle'] = this.dispenserNozzle;
    data['dispenser_meter_volume'] = this.dispenserMeterVolume;
    data['dispenser_meter_amount'] = this.dispenserMeterAmount;
    data['product_code'] = this.productCode;
    data['product_description'] = this.productDescription;
    data['update_date'] = this.updateDate;
    return data;
  }
}
