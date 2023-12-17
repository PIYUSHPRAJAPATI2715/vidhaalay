// class SocialLoginModel {
//   bool? status;
//   dynamic message;
//   dynamic authToken;
//   Data? data;
//
//   SocialLoginModel({this.status, this.message, this.authToken, this.data});
//
//   SocialLoginModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     authToken = json['auth_token'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     data['auth_token'] = authToken;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   dynamic id;
//   bool? isDriver;
//   bool? isVendor;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic location;
//   dynamic name;
//   dynamic lastName;
//   dynamic email;
//   dynamic phone;
//   dynamic walletBalance;
//   dynamic earnedBalance;
//   dynamic profileImage;
//   dynamic referalCode;
//   bool? isDriverOnline;
//   bool? isVendorOnline;
//   dynamic deliveryRange;
//   bool? selfDelivery;
//   bool? asDriverVerified;
//   bool? asVendorVerified;
//   bool? isProfileComplete;
//
//   Data(
//       {this.id,
//         this.isDriver,
//         this.isVendor,
//         this.latitude,
//         this.longitude,
//         this.location,
//         this.name,
//         this.lastName,
//         this.email,
//         this.phone,
//         this.walletBalance,
//         this.earnedBalance,
//         this.profileImage,
//         this.referalCode,
//         this.isDriverOnline,
//         this.isVendorOnline,
//         this.deliveryRange,
//         this.selfDelivery,
//         this.asDriverVerified,
//         this.asVendorVerified,
//         this.isProfileComplete});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     isDriver = json['is_driver'];
//     isVendor = json['is_vendor'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     location = json['location'];
//     name = json['name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     phone = json['phone'];
//     walletBalance = json['wallet_balance'];
//     earnedBalance = json['earned_balance'];
//     profileImage = json['profile_image'];
//     referalCode = json['referal_code'];
//     isDriverOnline = json['is_driver_online'];
//     isVendorOnline = json['is_vendor_online'];
//     deliveryRange = json['delivery_range'];
//     selfDelivery = json['self_delivery'];
//     asDriverVerified = json['as_driver_verified'];
//     asVendorVerified = json['as_vendor_verified'];
//     isProfileComplete = json['is_profile_complete'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['is_driver'] = isDriver;
//     data['is_vendor'] = isVendor;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['location'] = location;
//     data['name'] = name;
//     data['last_name'] = lastName;
//     data['email'] = email;
//     data['phone'] = phone;
//     data['wallet_balance'] = walletBalance;
//     data['earned_balance'] = earnedBalance;
//     data['profile_image'] = profileImage;
//     data['referal_code'] = referalCode;
//     data['is_driver_online'] = isDriverOnline;
//     data['is_vendor_online'] = isVendorOnline;
//     data['delivery_range'] = deliveryRange;
//     data['self_delivery'] = selfDelivery;
//     data['as_driver_verified'] = asDriverVerified;
//     data['as_vendor_verified'] = asVendorVerified;
//     data['is_profile_complete'] = isProfileComplete;
//     return data;
//   }
// }


class SocialLoginModel {
  Data? data;
  bool? status;
  dynamic msg;

  SocialLoginModel({this.data, this.status, this.msg});

  SocialLoginModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic uniqueId;
  dynamic mobile;
  dynamic dob;
  dynamic gender;
  dynamic profileImage;
  dynamic userType;
  dynamic soGoogle;
  dynamic soFacebook;
  dynamic emailOtp;
  dynamic mobileOtp;
  dynamic deviceType;
  dynamic fcmtoken;
  bool? emailVerified;
  bool? mobileVerified;
  dynamic latitude;
  dynamic longitude;
  dynamic address;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic token;

  Data(
      {this.id,
        this.name,
        this.email,
        this.uniqueId,
        this.mobile,
        this.dob,
        this.gender,
        this.profileImage,
        this.userType,
        this.soGoogle,
        this.soFacebook,
        this.emailOtp,
        this.mobileOtp,
        this.deviceType,
        this.fcmtoken,
        this.emailVerified,
        this.mobileVerified,
        this.latitude,
        this.longitude,
        this.address,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    uniqueId = json['unique_id'];
    mobile = json['mobile'];
    dob = json['dob'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    userType = json['user_type'];
    soGoogle = json['so_google'];
    soFacebook = json['so_facebook'];
    emailOtp = json['email_otp'];
    mobileOtp = json['mobile_otp'];
    deviceType = json['device_type'];
    fcmtoken = json['fcmtoken'];
    emailVerified = json['email_verified'];
    mobileVerified = json['mobile_verified'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['unique_id'] = this.uniqueId;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['user_type'] = this.userType;
    data['so_google'] = this.soGoogle;
    data['so_facebook'] = this.soFacebook;
    data['email_otp'] = this.emailOtp;
    data['mobile_otp'] = this.mobileOtp;
    data['device_type'] = this.deviceType;
    data['fcmtoken'] = this.fcmtoken;
    data['email_verified'] = this.emailVerified;
    data['mobile_verified'] = this.mobileVerified;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}

