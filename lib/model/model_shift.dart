class ModelShift {
  int? dayId;
  String? dayAccountdate;
  String? userFullname;
  int? shiftNo;
  String? shiftStartshift;
  int? shiftChange;

  ModelShift(
      {this.dayId,
      this.dayAccountdate,
      this.userFullname,
      this.shiftNo,
      this.shiftStartshift,
      this.shiftChange});

  ModelShift.fromJson(Map<String, dynamic> json) {
    dayId = json['day_id'];
    dayAccountdate = json['day_accountdate'];
    userFullname = json['user_fullname'];
    shiftNo = json['shift_no'];
    shiftStartshift = json['shift_startshift'];
    shiftChange = json['shift_change'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_id'] = this.dayId;
    data['day_accountdate'] = this.dayAccountdate;
    data['user_fullname'] = this.userFullname;
    data['shift_no'] = this.shiftNo;
    data['shift_startshift'] = this.shiftStartshift;
    data['shift_change'] = this.shiftChange;
    return data;
  }
}
