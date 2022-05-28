class MessageModel {
  String studentName;
  String subject;
  String text;
  String date;

  MessageModel({
    required this.studentName,
    required this.subject,
    required this.text,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentName': studentName,
      'subject': subject,
      'text': text,
      'date': date,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      studentName: map['studentName'] as String,
      subject: map['subject'] as String,
      text: map['text'] as String,
      date: map['date'] as String,
    );
  }



}

