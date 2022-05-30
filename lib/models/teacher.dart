class TeacherModel {
  String id;
  String name;
  String LastName;
  String? email;
  String? grade;
  String? avatar;

  TeacherModel({
    required this.id,
    required this.name,
    required this.LastName,
    this.grade,
    this.avatar,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': this.id,
      'name': this.name,
      'LastName': this.LastName,
      'email': this.email,
      'grade': this.grade,
      'avatar': this.avatar,
    };
  }

  factory TeacherModel.fromJson(Map<String, dynamic> map) {
    return TeacherModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      LastName: map['LastName'] as String,
      email: map['email'] as String,
      grade: map['grade'] as String,
      avatar: map['avatar'] as String,
    );
  }
}
