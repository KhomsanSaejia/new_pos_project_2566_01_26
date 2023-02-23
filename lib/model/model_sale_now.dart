class ModelSaleNow {
  int? dispenserId;
  int? dispenserNozzle;
  double? displayAmount;
  double? displayVolume;
  double? displayPrice;
  String? saleStatus;
  int? saleSelect;
  int? saleRecal;
  String? productCode;
  String? productDescription;

  ModelSaleNow(
      {this.dispenserId,
      this.dispenserNozzle,
      this.displayAmount,
      this.displayVolume,
      this.displayPrice,
      this.saleStatus,
      this.saleSelect,
      this.saleRecal,
      this.productCode,
      this.productDescription});

  ModelSaleNow.fromJson(Map<String, dynamic> json) {
    dispenserId = json['dispenser_id'];
    dispenserNozzle = json['dispenser_nozzle'];
    displayAmount = json['display_amount'];
    displayVolume = json['display_volume'];
    displayPrice = json['display_price'];
    saleStatus = json['sale_status'];
    saleSelect = json['sale_select'];
    saleRecal = json['sale_recal'];
    productCode = json['product_code'];
    productDescription = json['product_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dispenser_id'] = this.dispenserId;
    data['dispenser_nozzle'] = this.dispenserNozzle;
    data['display_amount'] = this.displayAmount;
    data['display_volume'] = this.displayVolume;
    data['display_price'] = this.displayPrice;
    data['sale_status'] = this.saleStatus;
    data['sale_select'] = this.saleSelect;
    data['sale_recal'] = this.saleRecal;
    data['product_code'] = this.productCode;
    data['product_description'] = this.productDescription;
    return data;
  }
}
