class Reminder {
  final int id;
  String title;
  String text;

  Reminder({this.id, this.title, this.text});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      text: json['text'],
    );
  }
}
