class DemandModel {

  String studentName;
  String subject;
  String raison;
  String? langue;
  String date;
  String status;

  DemandModel({
    required this.studentName,
    required this.subject,
    required this.raison,
    required this.date,
    this.langue,
    required this.status,

  });
  Map<String, dynamic> toMap() {
    return {
      'studentName': this.studentName,
      'subject': this.subject,
      'raison': this.raison,
      'langue': this.langue,
      'date': this.date,
      'status': this.status,
    };
  }

  factory DemandModel.fromJson(Map<String, dynamic> map) {
    return DemandModel(
      studentName: map['studentName'] as String,
      subject: map['subject'] as String,
      raison: map['raison'] as String,
      langue: map['langue'] as String,
      date: map['date'] as String,
      status: map['status'] as String,
    );
  }


}