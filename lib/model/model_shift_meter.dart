class ModelShiftMeter {
  int? id;
  int? dayId;
  int? shiftId;
  int? dispenserId;
  int? dispenserNozzle;
  String? productCode;
  String? productDescription;
  double? startMeterAmount;
  double? startMeterVolume;
  double? endMeterAmount;
  double? endMeterVolume;

  ModelShiftMeter(
      {this.id,
      this.dayId,
      this.shiftId,
      this.dispenserId,
      this.dispenserNozzle,
      this.productCode,
      this.productDescription,
      this.startMeterAmount,
      this.startMeterVolume,
      this.endMeterAmount,
      this.endMeterVolume});

  ModelShiftMeter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayId = json['day_id'];
    shiftId = json['shift_id'];
    dispenserId = json['dispenser_id'];
    dispenserNozzle = json['dispenser_nozzle'];
    productCode = json['product_code'];
    productDescription = json['product_description'];
    startMeterAmount = json['start_meter_amount'];
    startMeterVolume = json['start_meter_volume'];
    endMeterAmount = json['end_meter_amount'];
    endMeterVolume = json['end_meter_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day_id'] = this.dayId;
    data['shift_id'] = this.shiftId;
    data['dispenser_id'] = this.dispenserId;
    data['dispenser_nozzle'] = this.dispenserNozzle;
    data['product_code'] = this.productCode;
    data['product_description'] = this.productDescription;
    data['start_meter_amount'] = this.startMeterAmount;
    data['start_meter_volume'] = this.startMeterVolume;
    data['end_meter_amount'] = this.endMeterAmount;
    data['end_meter_volume'] = this.endMeterVolume;
    return data;
  }
}
