class ProfileModel {
  User? user;
  String? msg;

  ProfileModel({this.user, this.msg});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class User {
  String? sId;
  String? referenceWebsite;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? password;
  String? role;
  String? company;
  String? gstInNumber;
  bool? isRequestedForVendor;
  int? commissionRate;
  int? wallet;
  String? avatar;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
        this.referenceWebsite,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.address,
        this.password,
        this.role,
        this.company,
        this.gstInNumber,
        this.isRequestedForVendor,
        this.commissionRate,
        this.wallet,
        this.avatar,
        this.createdAt,
        this.updatedAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    referenceWebsite = json['referenceWebsite'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    password = json['password'];
    role = json['role'];
    company = json['company'];
    gstInNumber = json['gstInNumber'];
    isRequestedForVendor = json['isRequestedForVendor'];
    commissionRate = json['commissionRate'];
    wallet = json['wallet'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['referenceWebsite'] = this.referenceWebsite;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['password'] = this.password;
    data['role'] = this.role;
    data['company'] = this.company;
    data['gstInNumber'] = this.gstInNumber;
    data['isRequestedForVendor'] = this.isRequestedForVendor;
    data['commissionRate'] = this.commissionRate;
    data['wallet'] = this.wallet;
    data['avatar'] = this.avatar;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
