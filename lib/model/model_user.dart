class ModelUser {
  bool? status;
  int? respCode;
  RespMsg? respMsg;

  ModelUser({this.status, this.respCode, this.respMsg});

  ModelUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    respCode = json['resp_code'];
    respMsg = json['resp_msg'] != null
        ? RespMsg.fromJson(json['resp_msg'])
        : null;
  }


}

class RespMsg {
  int? userId;
  String? userUsername;
  String? userPassword;
  String? userPrefix;
  String? userFirstname;
  String? userLastname;
  String? userPhone;
  String? userPosition;
  String? userType;
  String? userEmail;
  String? startDate;
  String? endDate;
  String? userStatus;

  RespMsg(
      {this.userId,
      this.userUsername,
      this.userPassword,
      this.userPrefix,
      this.userFirstname,
      this.userLastname,
      this.userPhone,
      this.userPosition,
      this.userType,
      this.userEmail,
      this.startDate,
      this.endDate,
      this.userStatus});

  RespMsg.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userUsername = json['user_username'];
    userPassword = json['user_password'];
    userPrefix = json['user_prefix'];
    userFirstname = json['user_firstname'];
    userLastname = json['user_lastname'];
    userPhone = json['user_phone'];
    userPosition = json['user_position'];
    userType = json['user_type'];
    userEmail = json['user_email'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    userStatus = json['user_status'];
  }

  
}
