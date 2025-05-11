class UserInfo {
  String firstName;
  String lastName;
  String email;
  String gender;
  int age;
  int weight;
  double height;
  String goal;
  String activityLevel;
  String experienceLevel;
  int daysPerWeek;
  double bmi;

  UserInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.goal,
    required this.activityLevel,
    required this.experienceLevel,
    required this.daysPerWeek,
    required this.bmi,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    gender: json["gender"],
    age: json["age"],
    weight: json["weight"],
    height: json["height"]?.toDouble(),
    goal: json["goal"],
    activityLevel: json["activityLevel"],
    experienceLevel: json["experienceLevel"],
    daysPerWeek: json["daysPerWeek"],
    bmi: json["bmi"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "gender": gender,
    "age": age,
    "weight": weight,
    "height": height,
    "goal": goal,
    "activityLevel": activityLevel,
    "experienceLevel": experienceLevel,
    "daysPerWeek": daysPerWeek,
    "bmi": bmi,
  };
}