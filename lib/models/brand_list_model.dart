class BrandListModel {
  final bool? success;
  final int? total;
  final int? page;
  final int? limit;
  final List<Brand>? brands;

  const BrandListModel({
    this.success,
    this.total,
    this.page,
    this.limit,
    this.brands,
  });

  factory BrandListModel.fromJson(Map<String, dynamic> json) {
    return BrandListModel(
      success: json['success'] as bool?,
      total: json['total'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      brands: (json['brands'] as List<dynamic>?)
          ?.map((v) => Brand.fromJson(v as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'total': total,
    'page': page,
    'limit': limit,
    if (brands != null) 'brands': brands!.map((v) => v.toJson()).toList(),
  };

  BrandListModel copyWith({
    bool? success,
    int? total,
    int? page,
    int? limit,
    List<Brand>? brands,
  }) =>
      BrandListModel(
        success: success ?? this.success,
        total: total ?? this.total,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        brands: brands ?? this.brands,
      );

  @override
  String toString() =>
      'BrandListModel(success: $success, total: $total, page: $page, limit: $limit, brands: $brands)';
}

class Brand {
  final String? id;
  final String? sellerId;
  final String? name;
  final String? tagline;
  final String? description;
  final String? logo;
  final String? banner;
  final String? brandType;
  final String? gstNumber;
  final bool? trademarkRegistered;
  final String? supportEmail;
  final String? websiteUrl;
  final String? supportPhone;
  final String? status;
  final bool? isActive;
  final bool? isFeatured;
  final String? createdBy;
  final String? countryOfOrigin;
  final String? slug;
  final String? createdAt;
  final String? updatedAt;
  final int? version;

  const Brand({
    this.id,
    this.sellerId,
    this.name,
    this.tagline,
    this.description,
    this.logo,
    this.banner,
    this.brandType,
    this.gstNumber,
    this.trademarkRegistered,
    this.supportEmail,
    this.websiteUrl,
    this.supportPhone,
    this.status,
    this.isActive,
    this.isFeatured,
    this.createdBy,
    this.countryOfOrigin,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json['_id'] as String?,
    sellerId: json['sellerId'] as String?,
    name: json['name'] as String?,
    tagline: json['tagline'] as String?,
    description: json['description'] as String?,
    logo: json['logo'] as String?,
    banner: json['banner'] as String?,
    brandType: json['brandType'] as String?,
    gstNumber: json['gstNumber'] as String?,
    trademarkRegistered: json['trademarkRegistered'] as bool?,
    supportEmail: json['supportEmail'] as String?,
    websiteUrl: json['websiteUrl'] as String?,
    supportPhone: json['supportPhone'] as String?,
    status: json['status'] as String?,
    isActive: json['isActive'] as bool?,
    isFeatured: json['isFeatured'] as bool?,
    createdBy: json['createdBy'] as String?,
    countryOfOrigin: json['countryOfOrigin'] as String?,
    slug: json['slug'] as String?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    version: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'sellerId': sellerId,
    'name': name,
    'tagline': tagline,
    'description': description,
    'logo': logo,
    'banner': banner,
    'brandType': brandType,
    'gstNumber': gstNumber,
    'trademarkRegistered': trademarkRegistered,
    'supportEmail': supportEmail,
    'websiteUrl': websiteUrl,
    'supportPhone': supportPhone,
    'status': status,
    'isActive': isActive,
    'isFeatured': isFeatured,
    'createdBy': createdBy,
    'countryOfOrigin': countryOfOrigin,
    'slug': slug,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': version,
  };

  Brand copyWith({
    String? id,
    String? sellerId,
    String? name,
    String? tagline,
    String? description,
    String? logo,
    String? banner,
    String? brandType,
    String? gstNumber,
    bool? trademarkRegistered,
    String? supportEmail,
    String? websiteUrl,
    String? supportPhone,
    String? status,
    bool? isActive,
    bool? isFeatured,
    String? createdBy,
    String? countryOfOrigin,
    String? slug,
    String? createdAt,
    String? updatedAt,
    int? version,
  }) =>
      Brand(
        id: id ?? this.id,
        sellerId: sellerId ?? this.sellerId,
        name: name ?? this.name,
        tagline: tagline ?? this.tagline,
        description: description ?? this.description,
        logo: logo ?? this.logo,
        banner: banner ?? this.banner,
        brandType: brandType ?? this.brandType,
        gstNumber: gstNumber ?? this.gstNumber,
        trademarkRegistered: trademarkRegistered ?? this.trademarkRegistered,
        supportEmail: supportEmail ?? this.supportEmail,
        websiteUrl: websiteUrl ?? this.websiteUrl,
        supportPhone: supportPhone ?? this.supportPhone,
        status: status ?? this.status,
        isActive: isActive ?? this.isActive,
        isFeatured: isFeatured ?? this.isFeatured,
        createdBy: createdBy ?? this.createdBy,
        countryOfOrigin: countryOfOrigin ?? this.countryOfOrigin,
        slug: slug ?? this.slug,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        version: version ?? this.version,
      );

  @override
  String toString() => 'Brand(id: $id, name: $name, slug: $slug, '
      'status: $status, isActive: $isActive, isFeatured: $isFeatured)';
}