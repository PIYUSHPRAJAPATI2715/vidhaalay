class MyClass {
  final int id;
  final String name;

  MyClass({required this.id, required this.name});

  factory MyClass.fromJson(Map<String, dynamic> json) {
    return MyClass(
      id: json['id'],
      name: json['name'],
    );
  }
}
