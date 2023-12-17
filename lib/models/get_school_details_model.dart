class SchoolDetailsModel {
  Data? data;
  bool? status;
  String? msg;

  SchoolDetailsModel({this.data, this.status, this.msg});

  SchoolDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? address;
  List<String>? image;
  String? openTime;
  String? closeTime;
  Info? info;
  List<TopStudents>? topStudents;
  List<Achievements>? achievements;
  List<Gallery>? gallery;
  List<FeeStructure>? feeStructure;
  int? status;
  String? createdAt;
  String? updatedAt;
  Favourite? favourite;

  Data(
      {this.id,
        this.name,
        this.address,
        this.image,
        this.openTime,
        this.closeTime,
        this.info,
        this.topStudents,
        this.achievements,
        this.gallery,
        this.feeStructure,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.favourite});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    image = json['image'].cast<String>();
    openTime = json['open_time'];
    closeTime = json['close_time'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['top_students'] != null) {
      topStudents = <TopStudents>[];
      json['top_students'].forEach((v) {
        topStudents!.add(new TopStudents.fromJson(v));
      });
    }
    if (json['achievements'] != null) {
      achievements = <Achievements>[];
      json['achievements'].forEach((v) {
        achievements!.add(new Achievements.fromJson(v));
      });
    }
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    if (json['fee_structure'] != null) {
      feeStructure = <FeeStructure>[];
      json['fee_structure'].forEach((v) {
        feeStructure!.add(new FeeStructure.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    favourite = json['favourite'] != null
        ? new Favourite.fromJson(json['favourite'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['image'] = this.image;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.topStudents != null) {
      data['top_students'] = this.topStudents!.map((v) => v.toJson()).toList();
    }
    if (this.achievements != null) {
      data['achievements'] = this.achievements!.map((v) => v.toJson()).toList();
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.feeStructure != null) {
      data['fee_structure'] =
          this.feeStructure!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.favourite != null) {
      data['favourite'] = this.favourite!.toJson();
    }
    return data;
  }
}

class Info {
  String? aboutUs;
  String? principalDetail;
  List<String>? facilities;
  List<String>? features;
  String? principalImage;

  Info(
      {this.aboutUs,
        this.principalDetail,
        this.facilities,
        this.features,
        this.principalImage});

  Info.fromJson(Map<String, dynamic> json) {
    aboutUs = json['about_us'];
    principalDetail = json['principal_detail'];
    facilities = json['facilities'].cast<String>();
    features = json['features'].cast<String>();
    principalImage = json['principal_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about_us'] = this.aboutUs;
    data['principal_detail'] = this.principalDetail;
    data['facilities'] = this.facilities;
    data['features'] = this.features;
    data['principal_image'] = this.principalImage;
    return data;
  }
}

class TopStudents {
  String? name;
  String? classNo;
  String? image;

  TopStudents({this.name, this.classNo, this.image});

  TopStudents.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    classNo = json['classNo'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['classNo'] = this.classNo;
    data['image'] = this.image;
    return data;
  }
}

class Achievements {
  String? name;
  String? year;
  String? description;
  String? image;

  Achievements({this.name, this.year, this.description, this.image});

  Achievements.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    year = json['year'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['year'] = this.year;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}

class Gallery {
  String? url;

  Gallery({this.url});

  Gallery.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class FeeStructure {
  String? title;
  String? content;
  String? registration;
  String? quarter1;
  String? quarter2;
  String? quarter3;

  FeeStructure(
      {this.title,
        this.content,
        this.registration,
        this.quarter1,
        this.quarter2,
        this.quarter3});

  FeeStructure.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    registration = json['registration'];
    quarter1 = json['quarter1'];
    quarter2 = json['quarter2'];
    quarter3 = json['quarter3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['registration'] = this.registration;
    data['quarter1'] = this.quarter1;
    data['quarter2'] = this.quarter2;
    data['quarter3'] = this.quarter3;
    return data;
  }
}

class Favourite {
  int? id;
  String? favFor;
  int? favForId;
  int? userId;
  bool? favourite;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Favourite(
      {this.id,
        this.favFor,
        this.favForId,
        this.userId,
        this.favourite,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Favourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    favFor = json['fav_for'];
    favForId = json['fav_for_id'];
    userId = json['user_id'];
    favourite = json['favourite'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fav_for'] = this.favFor;
    data['fav_for_id'] = this.favForId;
    data['user_id'] = this.userId;
    data['favourite'] = this.favourite;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

// class SchoolDetailsModel {
//   Data? data;
//   bool? status;
//   String? msg;
//
//   SchoolDetailsModel({this.data, this.status, this.msg});
//
//   SchoolDetailsModel.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     status = json['status'];
//     msg = json['msg'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['status'] = this.status;
//     data['msg'] = this.msg;
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? name;
//   String? address;
//   List<String>? image;
//   String? openTime;
//   String? closeTime;
//   Info? info;
//   List<TopStudents>? topStudents;
//   List<Achievements>? achievements;
//   List<Gallery>? gallery;
//   List<FeeStructure>? feeStructure;
//   int? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Data({this.id, this.name, this.address, this.image, this.openTime, this.closeTime, this.info, this.topStudents, this.achievements, this.gallery, this.feeStructure, this.status, this.createdAt, this.updatedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     address = json['address'];
//     image = json['image'].cast<String>();
//     openTime = json['open_time'];
//     closeTime = json['close_time'];
//     info = json['info'] != null ? new Info.fromJson(json['info']) : null;
//     if (json['top_students'] != null) {
//       topStudents = <TopStudents>[];
//       json['top_students'].forEach((v) { topStudents!.add(new TopStudents.fromJson(v)); });
//     }
//     if (json['achievements'] != null) {
//       achievements = <Achievements>[];
//       json['achievements'].forEach((v) { achievements!.add(new Achievements.fromJson(v)); });
//     }
//     if (json['gallery'] != null) {
//       gallery = <Gallery>[];
//       json['gallery'].forEach((v) { gallery!.add(new Gallery.fromJson(v)); });
//     }
//     if (json['fee_structure'] != null) {
//       feeStructure = <FeeStructure>[];
//       json['fee_structure'].forEach((v) { feeStructure!.add(new FeeStructure.fromJson(v)); });
//     }
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['address'] = this.address;
//     data['image'] = this.image;
//     data['open_time'] = this.openTime;
//     data['close_time'] = this.closeTime;
//     if (this.info != null) {
//       data['info'] = this.info!.toJson();
//     }
//     if (this.topStudents != null) {
//       data['top_students'] = this.topStudents!.map((v) => v.toJson()).toList();
//     }
//     if (this.achievements != null) {
//       data['achievements'] = this.achievements!.map((v) => v.toJson()).toList();
//     }
//     if (this.gallery != null) {
//       data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
//     }
//     if (this.feeStructure != null) {
//       data['fee_structure'] = this.feeStructure!.map((v) => v.toJson()).toList();
//     }
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Info {
//   String? aboutUs;
//   String? principalImage;
//   String? principalDetail;
//   List<String>? facilities;
//   List<String>? features;
//
//   Info({this.aboutUs, this.principalImage, this.principalDetail, this.facilities, this.features});
//
//   Info.fromJson(Map<String, dynamic> json) {
//     aboutUs = json['about_us'];
//     principalImage = json['principal_image'];
//     principalDetail = json['principal_detail'];
//     facilities = json['facilities'].cast<String>();
//     features = json['features'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['about_us'] = this.aboutUs;
//     data['principal_image'] = this.principalImage;
//     data['principal_detail'] = this.principalDetail;
//     data['facilities'] = this.facilities;
//     data['features'] = this.features;
//     return data;
//   }
// }
//
// class TopStudents {
//   String? image;
//   String? name;
//   String? classNo;
//   String? percentage;
//
//   TopStudents({this.image, this.name, this.classNo, this.percentage});
//
//   TopStudents.fromJson(Map<String, dynamic> json) {
//   image = json['image'];
//   name = json['name'];
//   classNo = json['classNo'];
//   percentage = json['percentage'];
//   }
//
//   Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['image'] = this.image;
//   data['name'] = this.name;
//   data['classNo'] = this.classNo;
//   data['percentage'] = this.percentage;
//   return data;
//   }
// }
//
// class Achievements {
//   String? name;
//   String? image;
//   String? year;
//   String? description;
//
//   Achievements({this.name, this.image, this.year, this.description});
//
//   Achievements.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     image = json['image'];
//     year = json['year'];
//     description = json['description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['year'] = this.year;
//     data['description'] = this.description;
//     return data;
//   }
// }
//
// class Gallery {
//   String? url;
//
//   Gallery({this.url});
//
//   Gallery.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     return data;
//   }
// }
//
// class FeeStructure {
//   String? title;
//   String? registration;
//   String? quarter1;
//   String? quarter2;
//   String? quarter3;
//   String? content;
//
//   FeeStructure({this.title, this.registration, this.quarter1, this.quarter2, this.quarter3, this.content});
//
//   FeeStructure.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     registration = json['registration'];
//     quarter1 = json['quarter1'];
//     quarter2 = json['quarter2'];
//     quarter3 = json['quarter3'];
//     content = json['content'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['registration'] = this.registration;
//     data['quarter1'] = this.quarter1;
//     data['quarter2'] = this.quarter2;
//     data['quarter3'] = this.quarter3;
//     data['content'] = this.content;
//     return data;
//   }
// }
