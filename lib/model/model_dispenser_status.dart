class ModelDispenserStatus {
  int? id;
  int? dispenserId;
  int? dispenserNozzle;
  String? pumpStatus;
  double? displayAmount;
  double? displayVolume;
  double? displayPrice;
  String? updateDate;

  ModelDispenserStatus(
      {this.id,
      this.dispenserId,
      this.dispenserNozzle,
      this.pumpStatus,
      this.displayAmount,
      this.displayVolume,
      this.displayPrice,
      this.updateDate});

  ModelDispenserStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dispenserId = json['dispenser_id'];
    dispenserNozzle = json['dispenser_nozzle'];
    pumpStatus = json['pump_status'];
    displayAmount = json['display_amount'];
    displayVolume = json['display_volume'];
    displayPrice = json['display_price'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dispenser_id'] = this.dispenserId;
    data['dispenser_nozzle'] = this.dispenserNozzle;
    data['pump_status'] = this.pumpStatus;
    data['display_amount'] = this.displayAmount;
    data['display_volume'] = this.displayVolume;
    data['display_price'] = this.displayPrice;
    data['update_date'] = this.updateDate;
    return data;
  }
}
