class NoticeModel {

  String title;
  String message;
  String pdf;

  NoticeModel({
    required this.title,
    required this.message,
    required this.pdf,


  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'message': this.message,
      'pdf': this.pdf,
    };
  }

  factory NoticeModel.fromJson(Map<String, dynamic> map) {
    return NoticeModel(
      title: map['title'] as String,
      message: map['message'] as String,
      pdf: map['pdf'] as String,
    );
  }
}