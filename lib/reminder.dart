class Reminder {
  final int id;
  String title;
  String get get_title => title;
  set set_title(String new_title){
    title = new_title;
  }
  String text;
  String get get_text => text;
  set set_text(String new_text){
    text = new_text;
  }

  Reminder({this.id, this.title, this.text});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      text: json['text'],
    );
  }
}
