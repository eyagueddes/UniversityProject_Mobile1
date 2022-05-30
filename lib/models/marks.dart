import 'package:flutter/material.dart';

class DeliberationModel {
   String id;
   String classe;
   int? semester;
  String?  document;

   DeliberationModel({
    required this.id,
     required this.classe,
    this.semester,
   this.document,
  });


   Map<String, dynamic> toMap() {
    return {
      '_id': this.id,
      'classe': this.classe,
      'semester': this.semester,
      'document': this.document,
    };
  }

  factory DeliberationModel.fromMap(Map<String, dynamic> map) {
    return DeliberationModel(
      id: map['_id'] as String,
      classe: map['classe'] as String,
      semester: map['semester'] as int,
      document: map['document'] as String,
    );
  }

   @override
  String toString() {
    return 'DeliberationModel{id: $id, classe: $classe, semester: $semester, document: $document}';
  }

   factory DeliberationModel.fromJson(Map<String, dynamic> json)
   {
     return DeliberationModel (
       id: json['_id'],
       classe: json['classe'],
       semester: json['semester'],
       document: json['document'],
     );
   }

}