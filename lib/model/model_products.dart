class ModelProducts {
  int? id;
  String? productCode;
  String? productShort;
  String? productDescription;
  String? productType;
  double? productPrice;
  int? productQty;
  String? productUnits;
  String? productPic;
  String? productStatus;

  ModelProducts(
      {this.id,
      this.productCode,
      this.productShort,
      this.productDescription,
      this.productType,
      this.productPrice,
      this.productQty,
      this.productUnits,
      this.productPic,
      this.productStatus});

  ModelProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCode = json['product_code'];
    productShort = json['product_short'];
    productDescription = json['product_description'];
    productType = json['product_type'];
    productPrice = json['product_price'];
    productQty = json['product_qty'];
    productUnits = json['product_units'];
    productPic = json['product_pic'];
    productStatus = json['product_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_code'] = this.productCode;
    data['product_short'] = this.productShort;
    data['product_description'] = this.productDescription;
    data['product_type'] = this.productType;
    data['product_price'] = this.productPrice;
    data['product_qty'] = this.productQty;
    data['product_units'] = this.productUnits;
    data['product_pic'] = this.productPic;
    data['product_status'] = this.productStatus;
    return data;
  }
}
