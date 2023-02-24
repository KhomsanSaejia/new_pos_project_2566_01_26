class ModelSaleNow {
  int? id;
  int? dispenserId;
  int? dispenserNozzle;
  double? displayAmount;
  double? displayVolume;
  double? displayPrice;
  String? saleStatus;
  int? saleSelect;
  int? saleRecal;
  String? productCode;
  String? productShort;

  ModelSaleNow(
      {this.id,
      this.dispenserId,
      this.dispenserNozzle,
      this.displayAmount,
      this.displayVolume,
      this.displayPrice,
      this.saleStatus,
      this.saleSelect,
      this.saleRecal,
      this.productCode,
      this.productShort});

  ModelSaleNow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dispenserId = json['dispenser_id'];
    dispenserNozzle = json['dispenser_nozzle'];
    displayAmount = json['display_amount'];
    displayVolume = json['display_volume'];
    displayPrice = json['display_price'];
    saleStatus = json['sale_status'];
    saleSelect = json['sale_select'];
    saleRecal = json['sale_recal'];
    productCode = json['product_code'];
    productShort = json['product_short'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dispenser_id'] = this.dispenserId;
    data['dispenser_nozzle'] = this.dispenserNozzle;
    data['display_amount'] = this.displayAmount;
    data['display_volume'] = this.displayVolume;
    data['display_price'] = this.displayPrice;
    data['sale_status'] = this.saleStatus;
    data['sale_select'] = this.saleSelect;
    data['sale_recal'] = this.saleRecal;
    data['product_code'] = this.productCode;
    data['product_short'] = this.productShort;
    return data;
  }
}
