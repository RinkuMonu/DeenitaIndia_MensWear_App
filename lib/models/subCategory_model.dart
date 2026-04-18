class SubCategoryModel {
  final bool? success;
  final int? total;
  final int? page;
  final int? limit;
  final List<SubCategory>? categories;

  const SubCategoryModel({
    this.success,
    this.total,
    this.page,
    this.limit,
    this.categories,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        success: json['success'] as bool?,
        total: json['total'] as int?,
        page: json['page'] as int?,
        limit: json['limit'] as int?,
        categories: (json['categories'] as List<dynamic>?)
            ?.map((v) => SubCategory.fromJson(v as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'success': success,
    'total': total,
    'page': page,
    'limit': limit,
    if (categories != null)
      'categories': categories!.map((v) => v.toJson()).toList(),
  };

  SubCategoryModel copyWith({
    bool? success,
    int? total,
    int? page,
    int? limit,
    List<SubCategory>? categories,
  }) =>
      SubCategoryModel(
        success: success ?? this.success,
        total: total ?? this.total,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        categories: categories ?? this.categories,
      );

  @override
  String toString() =>
      'SubCategoryModel(success: $success, total: $total, page: $page, limit: $limit)';
}

// ─────────────────────────────────────────────
class SubCategory {
  final String? id;
  final CategoryRef? categoryId;
  final String? name;
  final String? slug;
  final String? smallImage;
  final String? bannerImage;
  final String? sizeType;
  final String? wearType;
  final List<String>? gender;
  final bool? showOnHome;
  final int? displayOrder;
  final Attributes? attributes;
  final List<String>? variantAttributes;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final int? version;

  const SubCategory({
    this.id,
    this.categoryId,
    this.name,
    this.slug,
    this.smallImage,
    this.bannerImage,
    this.sizeType,
    this.wearType,
    this.gender,
    this.showOnHome,
    this.displayOrder,
    this.attributes,
    this.variantAttributes,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json['_id'] as String?,
    categoryId: json['categoryId'] != null
        ? CategoryRef.fromJson(json['categoryId'] as Map<String, dynamic>)
        : null,
    name: json['name'] as String?,
    slug: json['slug'] as String?,
    smallImage: json['smallimage'] as String?,
    bannerImage: json['bannerimage'] as String?,
    sizeType: json['sizeType'] as String?,
    wearType: json['wearType'] as String?,
    gender: (json['gender'] as List<dynamic>?)?.cast<String>(),
    showOnHome: json['showOnHome'] as bool?,
    displayOrder: json['displayOrder'] as int?,
    attributes: json['attributes'] != null
        ? Attributes.fromJson(json['attributes'] as Map<String, dynamic>)
        : null,
    variantAttributes:
    (json['variantAttributes'] as List<dynamic>?)?.cast<String>(),
    isActive: json['isActive'] as bool?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    version: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    if (categoryId != null) 'categoryId': categoryId!.toJson(),
    'name': name,
    'slug': slug,
    'smallimage': smallImage,
    'bannerimage': bannerImage,
    'sizeType': sizeType,
    'wearType': wearType,
    'gender': gender,
    'showOnHome': showOnHome,
    'displayOrder': displayOrder,
    if (attributes != null) 'attributes': attributes!.toJson(),
    'variantAttributes': variantAttributes,
    'isActive': isActive,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': version,
  };

  SubCategory copyWith({
    String? id,
    CategoryRef? categoryId,
    String? name,
    String? slug,
    String? smallImage,
    String? bannerImage,
    String? sizeType,
    String? wearType,
    List<String>? gender,
    bool? showOnHome,
    int? displayOrder,
    Attributes? attributes,
    List<String>? variantAttributes,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    int? version,
  }) =>
      SubCategory(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        smallImage: smallImage ?? this.smallImage,
        bannerImage: bannerImage ?? this.bannerImage,
        sizeType: sizeType ?? this.sizeType,
        wearType: wearType ?? this.wearType,
        gender: gender ?? this.gender,
        showOnHome: showOnHome ?? this.showOnHome,
        displayOrder: displayOrder ?? this.displayOrder,
        attributes: attributes ?? this.attributes,
        variantAttributes: variantAttributes ?? this.variantAttributes,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        version: version ?? this.version,
      );

  @override
  String toString() =>
      'SubCategory(id: $id, name: $name, slug: $slug, isActive: $isActive)';
}

// ─────────────────────────────────────────────
class CategoryRef {
  final String? id;
  final String? name;
  final String? slug;

  const CategoryRef({this.id, this.name, this.slug});

  factory CategoryRef.fromJson(Map<String, dynamic> json) => CategoryRef(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    slug: json['slug'] as String?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'slug': slug,
  };

  CategoryRef copyWith({String? id, String? name, String? slug}) => CategoryRef(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
  );

  @override
  String toString() => 'CategoryRef(id: $id, name: $name, slug: $slug)';
}

// ─────────────────────────────────────────────
/// A single attribute option (e.g. fabric, pattern, fit…).
/// Formerly misnamed [Fabric] — now correctly named [AttributeOption].
class AttributeOption {
  final List<String>? values;
  final bool? required;
  final bool? filterable;
  final String? id;

  const AttributeOption({
    this.values,
    this.required,
    this.filterable,
    this.id,
  });

  factory AttributeOption.fromJson(Map<String, dynamic> json) =>
      AttributeOption(
        values: (json['values'] as List<dynamic>?)?.cast<String>(),
        required: json['required'] as bool?,
        filterable: json['filterable'] as bool?,
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'values': values,
    'required': required,
    'filterable': filterable,
    '_id': id,
  };

  AttributeOption copyWith({
    List<String>? values,
    bool? required,
    bool? filterable,
    String? id,
  }) =>
      AttributeOption(
        values: values ?? this.values,
        required: required ?? this.required,
        filterable: filterable ?? this.filterable,
        id: id ?? this.id,
      );

  @override
  String toString() =>
      'AttributeOption(id: $id, values: $values, required: $required, filterable: $filterable)';
}

// ─────────────────────────────────────────────
class Attributes {
  final AttributeOption? fabric;
  final AttributeOption? pattern;
  final AttributeOption? fit;
  final AttributeOption? neck;
  final AttributeOption? sleeveLength;
  final AttributeOption? length;
  final AttributeOption? occasion;
  final AttributeOption? closure;
  final AttributeOption? transparency;
  final AttributeOption? stretch;
  final AttributeOption? washCare;
  final AttributeOption? bottomType;
  final AttributeOption? season;
  final AttributeOption? waistband;
  final AttributeOption? rise;
  final AttributeOption? coverage;
  final AttributeOption? packOf;
  final AttributeOption? sareeType;
  final AttributeOption? borderType;
  final AttributeOption? palluStyle;
  final AttributeOption? blouseIncluded;
  final AttributeOption? blouseFabric;
  final AttributeOption? blouseWork;
  final AttributeOption? weight;
  final AttributeOption? waistRise;
  final AttributeOption? pocketType;
  final AttributeOption? activityType;
  final AttributeOption? fade;
  // Note: 'fabirc' is a typo in the API — kept as-is to match the JSON key.
  final AttributeOption? fabirc;
  final AttributeOption? collar;
  final AttributeOption? sleeve;
  final AttributeOption? pocket;
  final AttributeOption? wash;
  final AttributeOption? sustainability;

  const Attributes({
    this.fabric,
    this.pattern,
    this.fit,
    this.neck,
    this.sleeveLength,
    this.length,
    this.occasion,
    this.closure,
    this.transparency,
    this.stretch,
    this.washCare,
    this.bottomType,
    this.season,
    this.waistband,
    this.rise,
    this.coverage,
    this.packOf,
    this.sareeType,
    this.borderType,
    this.palluStyle,
    this.blouseIncluded,
    this.blouseFabric,
    this.blouseWork,
    this.weight,
    this.waistRise,
    this.pocketType,
    this.activityType,
    this.fade,
    this.fabirc,
    this.collar,
    this.sleeve,
    this.pocket,
    this.wash,
    this.sustainability,
  });

  /// Helper to reduce boilerplate: parse a nullable attribute entry.
  static AttributeOption? _parse(dynamic value) => value != null
      ? AttributeOption.fromJson(value as Map<String, dynamic>)
      : null;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    fabric: _parse(json['fabric']),
    pattern: _parse(json['pattern']),
    fit: _parse(json['fit']),
    neck: _parse(json['neck']),
    sleeveLength: _parse(json['sleeveLength']),
    length: _parse(json['length']),
    occasion: _parse(json['occasion']),
    closure: _parse(json['closure']),
    transparency: _parse(json['transparency']),
    stretch: _parse(json['stretch']),
    washCare: _parse(json['washCare']),
    bottomType: _parse(json['bottomType']),
    season: _parse(json['season']),
    waistband: _parse(json['waistband']),
    rise: _parse(json['rise']),
    coverage: _parse(json['coverage']),
    packOf: _parse(json['packOf']),
    sareeType: _parse(json['sareeType']),
    borderType: _parse(json['borderType']),
    palluStyle: _parse(json['palluStyle']),
    blouseIncluded: _parse(json['blouseIncluded']),
    blouseFabric: _parse(json['blouseFabric']),
    blouseWork: _parse(json['blouseWork']),
    weight: _parse(json['weight']),
    waistRise: _parse(json['waistRise']),
    pocketType: _parse(json['pocketType']),
    activityType: _parse(json['activityType']),
    fade: _parse(json['fade']),
    fabirc: _parse(json['fabirc']),
    collar: _parse(json['collar']),
    sleeve: _parse(json['sleeve']),
    pocket: _parse(json['pocket']),
    wash: _parse(json['wash']),
    sustainability: _parse(json['sustainability']),
  );

  Map<String, dynamic> toJson() => {
    if (fabric != null) 'fabric': fabric!.toJson(),
    if (pattern != null) 'pattern': pattern!.toJson(),
    if (fit != null) 'fit': fit!.toJson(),
    if (neck != null) 'neck': neck!.toJson(),
    if (sleeveLength != null) 'sleeveLength': sleeveLength!.toJson(),
    if (length != null) 'length': length!.toJson(),
    if (occasion != null) 'occasion': occasion!.toJson(),
    if (closure != null) 'closure': closure!.toJson(),
    if (transparency != null) 'transparency': transparency!.toJson(),
    if (stretch != null) 'stretch': stretch!.toJson(),
    if (washCare != null) 'washCare': washCare!.toJson(),
    if (bottomType != null) 'bottomType': bottomType!.toJson(),
    if (season != null) 'season': season!.toJson(),
    if (waistband != null) 'waistband': waistband!.toJson(),
    if (rise != null) 'rise': rise!.toJson(),
    if (coverage != null) 'coverage': coverage!.toJson(),
    if (packOf != null) 'packOf': packOf!.toJson(),
    if (sareeType != null) 'sareeType': sareeType!.toJson(),
    if (borderType != null) 'borderType': borderType!.toJson(),
    if (palluStyle != null) 'palluStyle': palluStyle!.toJson(),
    if (blouseIncluded != null) 'blouseIncluded': blouseIncluded!.toJson(),
    if (blouseFabric != null) 'blouseFabric': blouseFabric!.toJson(),
    if (blouseWork != null) 'blouseWork': blouseWork!.toJson(),
    if (weight != null) 'weight': weight!.toJson(),
    if (waistRise != null) 'waistRise': waistRise!.toJson(),
    if (pocketType != null) 'pocketType': pocketType!.toJson(),
    if (activityType != null) 'activityType': activityType!.toJson(),
    if (fade != null) 'fade': fade!.toJson(),
    if (fabirc != null) 'fabirc': fabirc!.toJson(),
    if (collar != null) 'collar': collar!.toJson(),
    if (sleeve != null) 'sleeve': sleeve!.toJson(),
    if (pocket != null) 'pocket': pocket!.toJson(),
    if (wash != null) 'wash': wash!.toJson(),
    if (sustainability != null) 'sustainability': sustainability!.toJson(),
  };
}