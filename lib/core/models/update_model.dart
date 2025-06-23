class UpdateData {
  final String fName;
  final String lName;
  final String email;
  final int age;
  final int weight;
  final int height;

  UpdateData({
    required this.fName,
    required this.lName,
    required this.email,
    required this.age,
    required this.weight,
    required this.height,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': fName,
      'lastName': lName,
      'email': email,
      'age': age,
      'weight': weight,
      'height': height,
    };
  }

}