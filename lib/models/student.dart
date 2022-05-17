 class StudentModel
{
  String name;
  String uId;
  String LastName;
  String numInscription;
  String classe;
  String email;
  String dateBirth;
  String adress;
  String phone;
  String avatar;
  String gender;
  String government;
  String country;


  StudentModel({
    required this.name,
    required this.uId,
    required this.LastName,
    required this.numInscription,
    required this.classe,
    required this.email,
    required this.dateBirth,
    required this.adress,
    required this.phone,
    required this.avatar,
    required this.gender,
    required this.government,
    required this.country,
  });


  factory StudentModel.fromJson(Map<String, dynamic> json)
  {
    return StudentModel(
        name: json['name'],
        uId: json['uId'],
        LastName: json['LastName'],
        numInscription: json['numInscription'],
        classe : json['classe'],
        email : json['email'],
        dateBirth : json['dateBirth'],
        adress : json['adress'],
        phone : json['phone'],
        avatar : json['avatar'],
        gender : json['gender'],
        government : json['government'],
        country : json['country'],

    );
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'LastName':LastName,
      'numInscription':numInscription,
      'classe':classe,
      'email':email,
    };
  }
}