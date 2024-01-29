class MultiLoginModel {
  String userName;
  String email;
  String type;
  String password;

  MultiLoginModel({
    required this.userName,
    required this.email,
    required this.type,
    required this.password,
  });

  // Convert the object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'type': type,
      'password': password,
    };
  }

  // Create an object from JSON
  factory MultiLoginModel.fromJson(Map<String, dynamic> json) {
    return MultiLoginModel(
      userName: json['userName'],
      email: json['email'],
      type: json['type'],
      password: json['password'],
    );
  }
}
