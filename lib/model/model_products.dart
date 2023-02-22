class ModelProducts {
  int? id;
  String? productCode;
  String? productDescription;
  String? productType;
  double? productPrice;
  int? productQty;
  String? productUnits;

  ModelProducts(
      {this.id,
      this.productCode,
      this.productDescription,
      this.productType,
      this.productPrice,
      this.productQty,
      this.productUnits});

  ModelProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCode = json['product_code'];
    productDescription = json['product_description'];
    productType = json['product_type'];
    productPrice = json['product_price'];
    productQty = json['product_qty'];
    productUnits = json['product_units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_code'] = this.productCode;
    data['product_description'] = this.productDescription;
    data['product_type'] = this.productType;
    data['product_price'] = this.productPrice;
    data['product_qty'] = this.productQty;
    data['product_units'] = this.productUnits;
    return data;
  }
}
