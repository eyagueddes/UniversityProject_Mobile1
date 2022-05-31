class MessageModel {
  String studentName;
  String subject;
  String text;
  String date;
  String? studentAvatar;

  MessageModel({
    required this.studentName,
    required this.subject,
    required this.text,
    required this.date,
     this.studentAvatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentName': studentName,
      'subject': subject,
      'text': text,
      'date': date,
      'studentAvatar':studentAvatar,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      studentName: map['studentName'] as String,
      subject: map['subject'] as String,
      text: map['text'] as String,
      date: map['date'] as String,
      studentAvatar: map['studentAvatar'] as String,

    );
  }



}

