class AddmissionModelUser {
  Data? data;
  bool? status;
  String? msg;

  AddmissionModelUser({this.data, this.status, this.msg});

  AddmissionModelUser.fromJson(Map<String, dynamic> json) {
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
  int? status;
  int? id;
  String? appliedFor;
  int? appliedForId;
  StudentInfo? studentInfo;
  ResidentialInfo? residentialInfo;
  ResidentialInfo? prevSchoolInfo;
  ResidentialInfo? fatherInfo;
  ResidentialInfo? motherInfo;
  ResidentialInfo? siblingInfo;
  int? userId;
  String? updatedAt;
  String? createdAt;
  Null? deletedAt;

  Data(
      {this.status,
        this.id,
        this.appliedFor,
        this.appliedForId,
        this.studentInfo,
        this.residentialInfo,
        this.prevSchoolInfo,
        this.fatherInfo,
        this.motherInfo,
        this.siblingInfo,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    appliedFor = json['applied_for'];
    appliedForId = json['applied_for_id'];
    studentInfo = json['student_info'] != null
        ? new StudentInfo.fromJson(json['student_info'])
        : null;
    residentialInfo = json['residential_info'] != null
        ? new ResidentialInfo.fromJson(json['residential_info'])
        : null;
    prevSchoolInfo = json['prev_school_info'] != null
        ? new ResidentialInfo.fromJson(json['prev_school_info'])
        : null;
    fatherInfo = json['father_info'] != null
        ? new ResidentialInfo.fromJson(json['father_info'])
        : null;
    motherInfo = json['mother_info'] != null
        ? new ResidentialInfo.fromJson(json['mother_info'])
        : null;
    siblingInfo = json['sibling_info'] != null
        ? new ResidentialInfo.fromJson(json['sibling_info'])
        : null;
    userId = json['user_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['applied_for'] = this.appliedFor;
    data['applied_for_id'] = this.appliedForId;
    if (this.studentInfo != null) {
      data['student_info'] = this.studentInfo!.toJson();
    }
    if (this.residentialInfo != null) {
      data['residential_info'] = this.residentialInfo!.toJson();
    }
    if (this.prevSchoolInfo != null) {
      data['prev_school_info'] = this.prevSchoolInfo!.toJson();
    }
    if (this.fatherInfo != null) {
      data['father_info'] = this.fatherInfo!.toJson();
    }
    if (this.motherInfo != null) {
      data['mother_info'] = this.motherInfo!.toJson();
    }
    if (this.siblingInfo != null) {
      data['sibling_info'] = this.siblingInfo!.toJson();
    }
    data['user_id'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

class StudentInfo {
  String? dob;
  String? category;
  String? motherTongue;
  String? name;
  String? fatherName;
  String? motherName;
  String? adharNo;
  String? bloodGroup;
  String? gender;

  StudentInfo(
      {this.dob,
        this.category,
        this.motherTongue,
        this.name,
        this.fatherName,
        this.motherName,
        this.adharNo,
        this.bloodGroup,
        this.gender});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    category = json['category'];
    motherTongue = json['mother_tongue'];
    name = json['name'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    adharNo = json['adhar_no'];
    bloodGroup = json['blood_group'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['category'] = this.category;
    data['mother_tongue'] = this.motherTongue;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['adhar_no'] = this.adharNo;
    data['blood_group'] = this.bloodGroup;
    data['gender'] = this.gender;
    return data;
  }
}

class ResidentialInfo {
  String? religion;
  String? nationality;
  String? address;
  String? city;
  String? state;
  String? pincode;

  ResidentialInfo(
      {this.religion,
        this.nationality,
        this.address,
        this.city,
        this.state,
        this.pincode});

  ResidentialInfo.fromJson(Map<String, dynamic> json) {
    religion = json['religion'];
    nationality = json['nationality'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['religion'] = this.religion;
    data['nationality'] = this.nationality;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    return data;
  }
}
