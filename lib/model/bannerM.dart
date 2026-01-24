class BannerModel {
  String? message;
  List<BannersData>? banners;

  BannerModel({this.message, this.banners});

  BannerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['banners'] != null) {
      banners = <BannersData>[];
      json['banners'].forEach((v) {
        banners!.add(new BannersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannersData {
  String? sId;
  String? referenceWebsite;
  String? bannerName;
  String? description;
  String? deviceType;
  List<String>? images;
  String? position;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BannersData(
      {this.sId,
        this.referenceWebsite,
        this.bannerName,
        this.description,
        this.deviceType,
        this.images,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.iV});

  BannersData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    referenceWebsite = json['referenceWebsite'];
    bannerName = json['bannerName'];
    description = json['description'];
    deviceType = json['deviceType'];
    images = json['images'].cast<String>();
    position = json['position'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['referenceWebsite'] = this.referenceWebsite;
    data['bannerName'] = this.bannerName;
    data['description'] = this.description;
    data['deviceType'] = this.deviceType;
    data['images'] = this.images;
    data['position'] = this.position;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
