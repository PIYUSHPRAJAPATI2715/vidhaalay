class AdmissionBodyModel {
  String? appliedFor;
  String? appliedForId;
  StudentInfo? studentInfo;
  ResidentialInfo? residentialInfo;
  ResidentialInfo? prevSchoolInfo;
  ResidentialInfo? fatherInfo;
  ResidentialInfo? motherInfo;
  List<SiblingInfo>? siblingInfo;

  AdmissionBodyModel(
      {this.appliedFor,
        this.appliedForId,
        this.studentInfo,
        this.residentialInfo,
        this.prevSchoolInfo,
        this.fatherInfo,
        this.motherInfo,
        this.siblingInfo});

  AdmissionBodyModel.fromJson(Map<String, dynamic> json) {
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
    if (json['sibling_info'] != null) {
      siblingInfo = <SiblingInfo>[];
      json['sibling_info'].forEach((v) {
        siblingInfo!.add(new SiblingInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
      data['sibling_info'] = this.siblingInfo!.map((v) => v.toJson()).toList();
    }
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

class SiblingInfo {
  String? name;
  String? className;
  String? schoolName;

  SiblingInfo({this.name, this.className, this.schoolName});

  SiblingInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    className = json['className'];
    schoolName = json['schoolName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['className'] = this.className;
    data['schoolName'] = this.schoolName;
    return data;
  }
}
