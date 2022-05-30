class ActualityModel {

  String subject;
  String? description;
  String? date;
  String? image;

  ActualityModel(
      {
      required this.subject,
      this.description,
      this.date,
      required,
      this.image});

  Map<String, dynamic> toMap() {
    return {

      'subject': this.subject,
      'description': this.description,
      'date': this.date,
      'image': this.image,
    };
  }

  factory ActualityModel.fromJson(Map<String, dynamic> map) {
    return ActualityModel(

      subject: map['subject'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
image: map['image'] as String,
    );
  }


}
