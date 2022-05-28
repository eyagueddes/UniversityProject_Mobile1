
class StudentData {
   String? name;
   String id;
   String? LastName;
   String? numInscription;
   String? classe;
   String? email;
   String? dateBirth;
   String? adress;
   String? phone;
   String? avatar;
   String? gender;
   String? government;
   String? country;


   StudentData({
     required this.name,
     required this.id,
     required this.LastName,
     required this.numInscription,
     required this.classe,
      this.email,
     this.dateBirth,
      this.adress,
     this.phone,
      this.avatar,
    this.gender,
      this.government,
     this.country,
   });



   factory StudentData.fromJson(Map<String, dynamic> json)
   {
     return StudentData(
       name: json['name'],
       id: json['_id'],
       LastName: json['LastName'],
       numInscription: json['numInscription'],
       classe: json['classe'],
       email: json['email'],
       dateBirth: json['dateBirth'],
       adress: json['adress'],
       phone: json['phone'],
       avatar: json['avatar'],
       gender: json['gender'],
       government: json['government'],
       country: json['country'],

     );
   }



  factory StudentData.fromMap(Map<String, dynamic> map) {
    return StudentData(
      name: map['name'] as String,
      id: map['_id'] as String,
      LastName: map['LastName'] as String,
      classe: map['classe'] as String,
      dateBirth: map['dateBirth'] as String,
      adress: map['adress'] as String,
      phone: map['phone'] as String,
      avatar: map['avatar'] as String,
      gender: map['gender'] as String,
      email: map['email'] as String,
      government: map['government'] as String,
      country: map['country'] as String,
      numInscription: map['numInscription'] as String,
    );
  }
}
