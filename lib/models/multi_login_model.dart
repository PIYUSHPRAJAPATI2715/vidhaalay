class MultiLoginModel {
  String userName;
  String email;
  String type;
  String password;
  String token;

  MultiLoginModel({
    required this.userName,
    required this.email,
    required this.type,
    required this.password,
    required this.token,
  });

  // Convert the object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'type': type,
      'password': password,
      'token': token,
    };
  }

  factory MultiLoginModel.fromJson(Map<String, dynamic> json) {
    return MultiLoginModel(
      userName: json['userName'] ?? "", // Use an empty string if 'userName' is null
      email: json['email'] ?? "",       // Use an empty string if 'email' is null
      type: json['type'] ?? "",         // Use an empty string if 'type' is null
      password: json['password'] ?? "", // Use an empty string if 'password' is null
      token: json['token'] ?? "",       // Use an empty string if 'token' is null
    );
  }
}