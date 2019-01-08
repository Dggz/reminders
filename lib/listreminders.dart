import 'package:flutter/material.dart';
import 'reminder.dart';


class ReminderScreen extends StatelessWidget {
  final Reminder reminder;

  ReminderScreen({Key key, this.reminder}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    TextEditingController _txtcontroller = new TextEditingController(text: reminder.text);
    _controller.text = reminder.title;
    _txtcontroller.text = reminder.text;

    return Scaffold(
      appBar: AppBar(
        title: Text("${reminder.title}"),
      ),

      body: Padding(
        padding: EdgeInsets.all(22.0),
        child: TextFormField(
          controller: _txtcontroller,
          decoration: InputDecoration(
              labelText: 'Reminder text'
          ),
        ),
      ),
    );
  }
}


class ListViewReminders extends StatelessWidget {
  final List<Reminder> reminders;

  ListViewReminders({Key key, this.reminders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: reminders.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {

            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReminderScreen(reminder: reminders[position])),
                  );
                },
                title: Text(
                  '${reminders[position].title}',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                subtitle: Text(
                  '${reminders[position].text}',
                  style: new TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                ),
              ],
            );
          }),
    );
  }


  void _onTapItem(BuildContext context, Reminder reminder) {
    Scaffold
        .of(context)
        .showSnackBar(new SnackBar(content: new Text(reminder.id.toString() + ' - ' + reminder.title)));
  }
}
